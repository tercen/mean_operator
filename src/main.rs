use polars::prelude::*;

#[tokio::main]
async fn main() {
    let args: Vec<String> = std::env::args().collect();
    parse_args(&args);

    let client = match tercen_rs::TercenClient::from_env().await {
        Ok(c) => std::sync::Arc::new(c),
        Err(e) => {
            eprintln!("Failed to connect to Tercen: {}", e);
            std::process::exit(1);
        }
    };

    let task_id = std::env::var("TERCEN_TASK_ID").unwrap_or_default();
    if task_id.is_empty() {
        eprintln!("TERCEN_TASK_ID not set");
        std::process::exit(1);
    }

    if let Err(e) = process_task(client, &task_id).await {
        eprintln!("Task failed: {}", e);
        std::process::exit(1);
    }
}

fn parse_args(args: &[String]) {
    let mut i = 1;
    while i < args.len() {
        match args[i].as_str() {
            "--taskId" if i + 1 < args.len() => {
                std::env::set_var("TERCEN_TASK_ID", &args[i + 1]);
                i += 2;
            }
            "--serviceUri" if i + 1 < args.len() => {
                std::env::set_var("TERCEN_URI", &args[i + 1]);
                i += 2;
            }
            "--token" if i + 1 < args.len() => {
                std::env::set_var("TERCEN_TOKEN", &args[i + 1]);
                i += 2;
            }
            _ => i += 1,
        }
    }
}

async fn process_task(
    client: std::sync::Arc<tercen_rs::TercenClient>,
    task_id: &str,
) -> Result<(), Box<dyn std::error::Error>> {
    println!("Mean Operator v{}", env!("CARGO_PKG_VERSION"));
    println!("Task ID: {}", task_id);

    let ctx = tercen_rs::ProductionContext::from_task_id(client.clone(), task_id).await?;

    // Fetch all data from the main table
    let df = ctx.select(None, 0, -1).await?;
    println!(
        "Data: {} rows, {} columns: {:?}",
        df.height(),
        df.width(),
        df.get_column_names()
    );

    // Compute mean(.y) per cell (.ci, .ri)
    let result_df = compute_mean(&df, ctx.namespace())?;

    println!(
        "Result: {} rows, {} columns",
        result_df.height(),
        result_df.width()
    );

    // Get task for saving
    let mut task_service = client.task_service()?;
    let request = tonic::Request::new(tercen_rs::client::proto::GetRequest {
        id: task_id.to_string(),
        ..Default::default()
    });
    let mut task = task_service.get(request).await?.into_inner();

    // Save tabular result
    ctx.save_table(&result_df, &mut task).await?;

    println!("Done!");
    Ok(())
}

/// Compute mean(.y) grouped by (.ci, .ri) → output column: `value`
fn compute_mean(
    df: &DataFrame,
    namespace: &str,
) -> Result<DataFrame, Box<dyn std::error::Error>> {
    let lf = df.clone().lazy();

    let result = lf
        .group_by([col(".ci"), col(".ri")])
        .agg([col(".y").mean().alias(&format!("{}.value", namespace))])
        .collect()?;

    Ok(result)
}

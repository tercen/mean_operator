suppressPackageStartupMessages({
  library(tercenApi)
  library(tercen)
  library(data.table)
  library(dtplyr)
  library(dplyr, warn.conflicts = FALSE)
})

ctx = tercenCtx()

if(ctx$hasNumericXAxis) {
  
  ctx  %>% 
    select(.y, .x, .ci, .ri) %>% 
    lazy_dt() %>%
    group_by(.ci, .ri) %>%
    summarise(mean_y = mean(.y), mean_x = mean(.x)) %>%
    as_tibble() %>%
    ctx$addNamespace() %>%
    ctx$save()
  
} else {
  
  ctx  %>% 
    select(.y, .ci, .ri) %>% 
    lazy_dt() %>%
    group_by(.ci, .ri) %>%
    summarise(value = mean(.y)) %>%
    as_tibble() %>%
    ctx$addNamespace() %>%
    ctx$save()
  
}

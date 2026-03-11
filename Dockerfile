FROM rust:1.86-bookworm AS builder

WORKDIR /app

# Copy manifests first for dependency caching
COPY Cargo.toml Cargo.lock ./

# Create dummy src to build dependencies
RUN mkdir src && echo 'fn main() {}' > src/main.rs
RUN cargo build --release 2>/dev/null || true

# Copy actual source
COPY src/ src/

# Build the real binary (touch to invalidate cache)
RUN touch src/main.rs && cargo build --release

# Runtime stage
FROM gcr.io/distroless/cc-debian12

COPY --from=builder /app/target/release/mean_operator /operator

ENTRYPOINT ["/operator"]

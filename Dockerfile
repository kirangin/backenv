FROM debian:bullseye-slim

# Install dependencies for Rust and protobuf
RUN apt-get update && apt-get install -y \
  curl \
  libssl-dev \
  pkg-config \
  protobuf-compiler \
  gcc \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Remove docs to save space
RUN rustup set profile minimal

# Set working directory to /app
WORKDIR /app
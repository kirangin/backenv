FROM debian:bullseye-slim

# Install dependencies for Rust and protobuf
RUN apt-get update && apt-get install -y \
  curl \
  libssl-dev \
  pkg-config \
  protobuf-compiler \
  gcc \
  libpq-dev \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add Rust to PATH
ENV PATH="/root/.cargo/bin:${PATH}"

# Remove docs to save space
RUN rustup set profile minimal

# Install 
RUN wget https://github.com/grpc-ecosystem/grpc-gateway/releases/download/v2.25.1/protoc-gen-openapiv2-v2.25.1-linux-x86_64 -O /usr/local/bin/protoc-gen-openapiv2

# Set working directory to /app
WORKDIR /app
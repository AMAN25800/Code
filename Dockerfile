# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      ca-certificates \
      wget \
      unzip \
      bash \
      dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go
RUN chmod +x /app/jiotv_go

# Expose service port
ENV PORT=10000
EXPOSE 10000

# Use token from mounted folder if available
# Default location inside container: /root/.jiotv/token.json
# You can mount host folder: -v /host/token-folder:/root/.jiotv
# This way, you can update token.json without rebuilding
CMD ["/app/jiotv_go", "serve", "--host", "0.0.0.0", "--port", "10000"]

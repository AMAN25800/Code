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

# Render exposes dynamic port using $PORT
ENV PORT=10000

# Expose the Render service port
EXPOSE 10000

# Start JioTV Go with Render's port
CMD ["/app/jiotv_go", "serve", "--host", "0.0.0.0", "--port", "10000"]

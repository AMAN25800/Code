# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Caddy manually
RUN wget -O /usr/bin/caddy "https://github.com/caddyserver/caddy/releases/latest/download/caddy_2.6.4_linux_amd64" \
    && chmod +x /usr/bin/caddy

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Set working directory
WORKDIR /app

# Copy Caddyfile for CORS headers
COPY Caddyfile /etc/caddy/Caddyfile

# Expose the port
EXPOSE 5001

# Start JioTV Go in the background, then Caddy
CMD ./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5001 & caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

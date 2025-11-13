# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      ca-certificates \
      wget \
      tar \
    && rm -rf /var/lib/apt/lists/*

# Install Caddy manually (download correct version)
RUN wget -O /tmp/caddy.tar.gz "https://github.com/caddyserver/caddy/releases/download/v2.10.1/caddy_2.10.1_linux_amd64.tar.gz" \
    && tar -xzf /tmp/caddy.tar.gz -C /tmp \
    && mv /tmp/caddy /usr/bin/caddy \
    && chmod +x /usr/bin/caddy \
    && rm /tmp/caddy.tar.gz

# Copy your JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Set working directory
WORKDIR /app

# Copy Caddy configuration
COPY Caddyfile /etc/caddy/Caddyfile

# Expose port your app and proxy will use
EXPOSE 5001

CMD ./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 & \
    caddy run --config /etc/caddy/Caddyfile --adapter caddyfile --listen :$PORT


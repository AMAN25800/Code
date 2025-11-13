# Stage 1: JioTV Go binary
FROM ubuntu:22.04 AS jiotv

WORKDIR /app
COPY jiotv_go-linux-amd64 .
RUN chmod +x jiotv_go-linux-amd64

# Stage 2: Caddy base image
FROM caddy:2

# Copy JioTV Go binary from previous stage
COPY --from=jiotv /app/jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64

# Copy Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Expose port (Caddy listens here)
EXPOSE 5001

# Start JioTV Go in background, then Caddy
CMD /app/jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5001 & caddy run --config /etc/caddy/Caddyfile --adapter caddyfile

# Step 1: Use Ubuntu
FROM ubuntu:22.04

# Step 2: Install dependencies
RUN apt-get update && apt-get install -y curl ca-certificates && rm -rf /var/lib/apt/lists/*

# Step 3: Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Step 4: Install Caddy (lightweight web server)
RUN curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | apt-key add - \
 && curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-stable.list \
 && apt-get update \
 && apt-get install -y caddy \
 && rm -rf /var/lib/apt/lists/*

# Step 5: Copy Caddyfile
COPY Caddyfile /etc/caddy/Caddyfile

# Step 6: Expose port
EXPOSE 5001

# Step 7: Start both services
CMD ["sh", "-c", "/app/jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5001"]

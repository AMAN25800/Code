# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    nginx \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Copy Nginx config
COPY nginx.conf /etc/nginx/conf.template.d/default.conf

# Expose ports
EXPOSE 80 5001

# Start backend and Nginx
CMD /app/jiotv_go-linux-amd64 & nginx -g "daemon off;"

# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    nginx \
    gettext-base \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Copy NGINX template
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Copy start script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Expose internal backend port
EXPOSE 5000

# Run start script
CMD ["/start.sh"]

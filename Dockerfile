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
COPY nginx.conf.template /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80 5001

# Run .exe and Nginx
CMD /app/jiotv_go-linux-amd64 serve & nginx -g "daemon off;"

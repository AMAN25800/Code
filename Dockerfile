# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    nginx \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy JioTV Go executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Remove default Nginx page
RUN rm -f /usr/share/nginx/html/index.html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose ports
EXPOSE 80 5001

# Start JioTV Go and Nginx
CMD /app/jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5001 & nginx -g "daemon off;"

FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    nginx \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Copy executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Copy NGINX template
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# Expose internal port for .exe (optional)
EXPOSE 5000

# Start executable and NGINX (with $PORT substitution)
CMD /app/jiotv_go-linux-amd64 & \
    envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && \
    nginx -g "daemon off;"

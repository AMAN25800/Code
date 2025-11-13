#!/bin/bash

# Start the backend executable on internal port 5000
/app/jiotv_go-linux-amd64 &

# Wait for port 5000 to be open
echo "Waiting for backend to start on port 5000..."
while ! nc -z localhost 5000; do
  sleep 1
done

# Substitute $PORT in NGINX template
envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Start NGINX in foreground
nginx -g "daemon off;"

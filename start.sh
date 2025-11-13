#!/bin/bash

# Start the backend executable on internal port 5000
/app/jiotv_go-linux-amd64 &

# Wait until port 5000 is open
echo "Waiting for backend to start on port 5000..."
while ! nc -z localhost 5000; do
  sleep 1
done

# Replace ${PORT} in NGINX template with Render's environment variable
envsubst '$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

# Start NGINX in foreground
nginx -g "daemon off;"

#!/bin/bash
set -e

# Start JioTV Go in background
/app/jiotv_go serve --host 0.0.0.0 --port 10000 &

# Start ngrok in background
ngrok http 10000 --authtoken="$NGROK_AUTHTOKEN" --log=stdout &

# Wait for ngrok to initialize
echo "Waiting for ngrok to start..."
sleep 5

# Fetch the public URL from ngrok API
NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels | \
    jq -r '.tunnels[0].public_url')

echo "====================================="
echo "🚀 JioTV Go is running at $NGROK_URL"
echo "====================================="

# Keep the container running
wait

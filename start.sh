#!/bin/bash

# Check if NGROK_AUTHTOKEN is set
if [ -z "$NGROK_AUTHTOKEN" ]; then
    echo "ERROR: NGROK_AUTHTOKEN is not set!"
    exit 1
fi

# Start JioTV Go server
/app/jiotv_go serve --host 0.0.0.0 --port 10000 &

# Start ngrok on the same port
ngrok http 10000 --authtoken="$NGROK_AUTHTOKEN" --log=stdout &
sleep 5

# Fetch and print the public ngrok URL
NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels | \
            jq -r '.tunnels[0].public_url')
echo "🚀 JioTV Go is publicly available at: $NGROK_URL"

# Keep the container running
wait

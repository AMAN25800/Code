#!/bin/bash
set -e

# Start JioTV Go in background
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &

# Export ngrok token from environment
export NGROK_AUTHTOKEN=$NGROK_AUTHTOKEN

# Start ngrok tunnel
ngrok http 5002 --log=stdout

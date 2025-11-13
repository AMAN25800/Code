#!/bin/bash
set -e

# Start JioTV Go on localhost:5002
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &
JTV_PID=$!

# Configure ngrok with auth token from environment
ngrok authtoken $NGROK_AUTH_TOKEN

# Start ngrok HTTP tunnel
ngrok http 5002 --log=stdout &
NGROK_PID=$!

# Wait for any process to exit
wait -n

# Kill all processes if one exits
kill $JTV_PID $NGROK_PID

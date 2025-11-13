#!/bin/bash
set -e

# Start JioTV Go on localhost:5002
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &
JTV_PID=$!

# Start ngrok to forward internal port 5002
# NGROK_AUTH_TOKEN should be set as an environment variable in Render
ngrok http 5002 --log=stdout &
NGROK_PID=$!

# Wait for any process to exit
wait -n

# Kill all processes if one exits
kill $JTV_PID $NGROK_PID

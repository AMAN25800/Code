#!/bin/bash

# Fail immediately if any command fails
set -e

# Check if NGROK_AUTHTOKEN is set
if [ -z "$NGROK_AUTHTOKEN" ]; then
  echo "ERROR: NGROK_AUTHTOKEN is not set!"
  exit 1
fi

# Authenticate ngrok
./ngrok config add-authtoken $NGROK_AUTHTOKEN

# Start JioTV Go in background
./jiotv_go serve --localhost --port $PORT &

# Wait a few seconds to ensure JioTV Go is running
sleep 2

# Start ngrok and print public URL
./ngrok http $PORT --log=stdout &
sleep 5

# Keep container running
tail -f /dev/null

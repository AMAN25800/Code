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

# Start JioTV Go on localhost (inside container)
./jiotv_go serve --host 127.0.0.1 --port $PORT &

# Wait a few seconds to ensure the server is running
sleep 2

# Start ngrok and expose LOCALHOST:PORT to the internet
./ngrok http 127.0.0.1:$PORT --log=stdout &
sleep 5

# Keep container alive
tail -f /dev/null

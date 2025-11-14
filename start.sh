#!/bin/bash
# start.sh

# Exit on error
set -e

# Start JioTV Go in background
/app/jiotv_go serve --host 0.0.0.0 --port 10000 &

# Start ngrok tunnel using env variable NGROK_AUTHTOKEN
./ngrok authtoken $NGROK_AUTHTOKEN
./ngrok http 10000 --log=stdout &

# Wait a few seconds for ngrok to start
sleep 5

# Get the public ngrok URL and print it
NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels | grep -oP '(?<=public_url":")[^"]+')
echo "=============================="
echo "Your ngrok URL is: $NGROK_URL"
echo "=============================="

# Keep the container running
wait

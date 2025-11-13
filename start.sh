#!/bin/bash
set -e

# Start JioTV Go in background
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &

# Start ngrok tunnel (replace YOUR_AUTHTOKEN with your ngrok authtoken)
ngrok config add-authtoken YOUR_AUTHTOKEN
ngrok http 5002 --log=stdout

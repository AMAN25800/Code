#!/bin/bash
set -e

# Start JioTV Go
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &

# Start ngrok with authtoken from environment variable
ngrok config add-authtoken $NGROK_AUTHTOKEN
ngrok http 5002 --log=stdout

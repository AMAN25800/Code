# start.sh
#!/bin/bash
set -e

# Start JioTV Go
./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5002 &

# Authenticate ngrok
ngrok config add-authtoken $NGROK_AUTH_TOKEN

# Start ngrok HTTP tunnel
ngrok tunnel http 5002

# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates wget unzip bash dos2unix jq && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go
RUN chmod +x /app/jiotv_go

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Install ngrok
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz && \
    tar -xvzf ngrok-v3-stable-linux-amd64.tgz && \
    mv ngrok /usr/local/bin/ && \
    rm ngrok-v3-stable-linux-amd64.tgz

# Expose port
EXPOSE 10000

# Start everything
CMD ["/app/start.sh"]

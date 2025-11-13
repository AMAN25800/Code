# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      ca-certificates \
      wget \
      unzip \
      bash \
    && rm -rf /var/lib/apt/lists/*

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Install ngrok
# Install ngrok v3
RUN wget -O /tmp/ngrok.zip "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" \
    && tar -xvzf /tmp/ngrok.zip -C /usr/local/bin \
    && chmod +x /usr/local/bin/ngrok \
    && rm /tmp/ngrok.zip
# Set working directory
WORKDIR /app

# Expose internal port
EXPOSE 5002 4040

# Copy startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Run startup script
CMD ["/app/start.sh"]

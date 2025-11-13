# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
      curl \
      ca-certificates \
      wget \
      tar \
      unzip \
      bash \
      dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Install ngrok v3
RUN wget -O /tmp/ngrok.tgz "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz" \
    && tar -xvzf /tmp/ngrok.tgz -C /usr/local/bin \
    && chmod +x /usr/local/bin/ngrok \
    && rm /tmp/ngrok.tgz

# Expose ports (JioTV Go + ngrok web interface)
EXPOSE 5002 4040

# Copy startup script
COPY start.sh /app/start.sh
RUN dos2unix /app/start.sh \
    && chmod +x /app/start.sh

# Run startup script
CMD ["/app/start.sh"]

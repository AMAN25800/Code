# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl ca-certificates wget unzip bash dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go
RUN chmod +x /app/jiotv_go

# Download ngrok
RUN curl -L -o ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok.zip && \
    chmod +x ngrok && \
    rm ngrok.zip

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose JioTV Go port
EXPOSE 10000

# Start container with script
CMD ["/app/start.sh"]

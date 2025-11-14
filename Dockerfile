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

# Copy ngrok
COPY ngrok /app/ngrok
RUN chmod +x /app/ngrok

# Copy start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Expose port
EXPOSE 10000

# Start script
CMD ["/app/start.sh"]

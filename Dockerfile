# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        bash \
        dos2unix \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go
RUN chmod +x /app/jiotv_go

# Download latest ngrok 3.x
RUN curl -L -o ngrok.zip https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip && \
    unzip ngrok.zip && \
    chmod +x ngrok && \
    rm ngrok.zip

# Expose JioTV Go port
ENV PORT=5001
EXPOSE 5001

# Environment variable for ngrok authtoken
# You must set NGROK_AUTHTOKEN when deploying
ENV NGROK_AUTHTOKEN="1aLCRoDgttlzs3oayQgVcfQkU9y_7mRVGoUMnVNd6e8YLBpUs"

# Copy the start script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Start JioTV Go and ngrok
CMD ["/app/start.sh"]

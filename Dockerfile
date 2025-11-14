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
      dos2unix \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy JioTV Go binary
COPY jiotv_go-linux-amd64 /app/jiotv_go
RUN chmod +x /app/jiotv_go

# Download latest ngrok v3
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz \
    && tar -xvzf ngrok-v3-stable-linux-amd64.tgz \
    && mv ngrok /usr/local/bin/ \
    && chmod +x /usr/local/bin/ngrok \
    && rm ngrok-v3-stable-linux-amd64.tgz


# Expose JioTV Go port
ENV PORT=10000
EXPOSE 10000

# Set your ngrok auth token here
ENV NGROK_AUTHTOKEN=1aLCRoDgttlzs3oayQgVcfQkU9y_7mRVGoUMnVNd6e8YLBpUs

# Start JioTV Go and ngrok continuously
CMD bash -c "\
    /app/jiotv_go serve --host 0.0.0.0 --port 10000 & \
    ngrok authtoken $NGROK_AUTHTOKEN && \
    ngrok http 10000 --log=stdout \
"

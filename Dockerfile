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

# Download and install ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip && \
    unzip ngrok-stable-linux-amd64.zip && \
    chmod +x ngrok && \
    mv ngrok /usr/local/bin/ngrok && \
    rm ngrok-stable-linux-amd64.zip

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

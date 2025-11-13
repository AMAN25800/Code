# Base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Expose internal port (optional, for documentation)
EXPOSE 5000

# Start the executable on the port provided by Render
CMD ["/app/jiotv_go-linux-amd64", "--port", "$PORT"]

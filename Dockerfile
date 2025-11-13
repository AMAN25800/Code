# Use Ubuntu 22.04 as base image
FROM ubuntu:22.04

# Install dependencies (if any)
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy the JioTV Go binary into the container
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64

# Make it executable
RUN chmod +x /app/jiotv_go-linux-amd64

# Set working directory
WORKDIR /app

# Expose default port if needed (adjust if JioTV Go uses a different port)
EXPOSE 5001

# Run the binary with the serve command
CMD ["./jiotv_go-linux-amd64", "serve"]

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

# Expose the port your app will use
EXPOSE 5001

# Run the binary with the serve command, binding to 0.0.0.0
CMD ["sh", "-c", "./jiotv_go-linux-amd64 serve --host 0.0.0.0 --port 5001"]

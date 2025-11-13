# Use Ubuntu 22.04 as base
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy the JioTV Go executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Expose the port that JioTV Go serves (default 5001)
EXPOSE 5001

# Start JioTV Go in serve mode
CMD ["/app/jiotv_go-linux-amd64", "serve"]

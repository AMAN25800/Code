FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Copy JioTV Go executable
COPY jiotv_go-linux-amd64 /app/jiotv_go-linux-amd64
RUN chmod +x /app/jiotv_go-linux-amd64

# Expose the port (optional)
EXPOSE 5001

# Start JioTV Go (shell form to expand $PORT)
CMD /app/jiotv_go-linux-amd64 serve --port $PORT

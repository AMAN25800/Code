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

# Start JioTV Go binding to all interfaces and Render's PORT
CMD /app/jiotv_go-linux-amd64 serve --host 0.0.0.0 --port $PORT

# Base image
FROM node:20-bullseye

# Install dependencies
WORKDIR /app

# Copy executable and Node server
COPY jiotv_go-linux-amd64 ./jiotv_go-linux-amd64
COPY server.js ./server.js

# Make executable runnable
RUN chmod +x ./jiotv_go-linux-amd64

# Expose internal port (optional)
EXPOSE 3000

# Start Node wrapper
CMD ["node", "server.js"]

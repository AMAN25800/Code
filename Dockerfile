FROM node:20-bullseye

WORKDIR /app

# Copy package.json first to install dependencies
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy server and executable
COPY server.js ./server.js
COPY jiotv_go-linux-amd64 ./jiotv_go-linux-amd64
COPY public ./public

# Make executable runnable
RUN chmod +x ./jiotv_go-linux-amd64

# Expose port
EXPOSE 3000

# Start server
CMD ["node", "server.js"]

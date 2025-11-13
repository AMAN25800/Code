const { spawn } = require("child_process");
const http = require("http");
const PORT = process.env.PORT || 3000;

// Start the backend executable
const backend = spawn("./jiotv_go-linux-amd64");

backend.stdout.on("data", (data) => {
  console.log(`[backend stdout]: ${data}`);
});

backend.stderr.on("data", (data) => {
  console.error(`[backend stderr]: ${data}`);
});

backend.on("exit", (code) => {
  console.log(`Backend exited with code ${code}`);
});

// Minimal HTTP server just to satisfy Render
const server = http.createServer((req, res) => {
  res.writeHead(200, {
    "Content-Type": "text/plain",
  });
  res.end("JioTV Go is running.\n");
});

server.listen(PORT, () => {
  console.log(`HTTP wrapper listening on port ${PORT}`);
});

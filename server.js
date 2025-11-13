const express = require("express");
const { exec } = require("child_process");
const path = require("path");

const app = express();
app.use(express.json());

const PORT = process.env.PORT || 3000;

// Serve frontend (optional)
app.use(express.static(path.join(__dirname, "public")));

// Status API
app.get("/api/status", (req, res) => {
  res.json({ status: "JioTV backend running" });
});

// Send OTP
app.post("/api/send-otp", (req, res) => {
  const phone = req.body.phone;
  if (!phone) return res.status(400).json({ error: "Phone number required" });

  exec(`./jiotv_go-linux-amd64 --send-otp ${phone}`, (err, stdout, stderr) => {
    if (err) return res.status(500).json({ error: stderr });
    res.json({ message: stdout.trim() });
  });
});

// Login with OTP
app.post("/api/login", (req, res) => {
  const { phone, otp } = req.body;
  if (!phone || !otp) return res.status(400).json({ error: "Phone & OTP required" });

  exec(`./jiotv_go-linux-amd64 --login ${phone} ${otp}`, (err, stdout, stderr) => {
    if (err) return res.status(500).json({ error: stderr });
    res.json({ message: stdout.trim() });
  });
});

// Fetch channels
app.get("/api/channels", (req, res) => {
  exec(`./jiotv_go-linux-amd64 --list-channels`, (err, stdout, stderr) => {
    if (err) return res.status(500).json({ error: stderr });
    try {
      const channels = JSON.parse(stdout); // assuming executable outputs JSON
      res.json({ channels });
    } catch {
      res.json({ raw: stdout });
    }
  });
});

// Start backend executable in background (if needed)
exec(`./jiotv_go-linux-amd64 &`, (err) => {
  if (err) console.error("Failed to start backend:", err);
});

app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));

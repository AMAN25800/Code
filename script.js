// Check backend status
fetch("/api/status")
  .then(res => res.json())
  .then(data => {
    document.getElementById("status").textContent = data.status;
  })
  .catch(err => {
    document.getElementById("status").textContent = "Backend not reachable";
    console.error(err);
  });

// Send OTP
document.getElementById("sendOtpBtn").addEventListener("click", () => {
  const phone = document.getElementById("phone").value;
  fetch("/api/send-otp", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ phone })
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("otpResult").textContent = data.message || data.error;
    })
    .catch(err => {
      document.getElementById("otpResult").textContent = "Error sending OTP";
      console.error(err);
    });
});

// Login with OTP
document.getElementById("loginBtn").addEventListener("click", () => {
  const phone = document.getElementById("phone").value;
  const otp = document.getElementById("otp").value;
  fetch("/api/login", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ phone, otp })
  })
    .then(res => res.json())
    .then(data => {
      document.getElementById("loginResult").textContent = data.message || data.error;
    })
    .catch(err => {
      document.getElementById("loginResult").textContent = "Error logging in";
      console.error(err);
    });
});

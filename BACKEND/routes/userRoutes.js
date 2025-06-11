// routes/userRoutes.js
const express = require("express");
const router = express.Router();
const User = require("../models/User");
// const multer = require('multer');
const path = require("path");

// // Set up storage engine for multer
// const storage = multer.diskStorage({
//   destination: './uploads/',
//   filename: function (req, file, cb) {
//     cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
//   },
// });

// const upload = multer({ storage: storage });

// Route to update user profile information
router.put("/:userId", async (req, res) => {
  const { userId } = req.params;
  const { bio, dateOfBirth } = req.body; // Removed profilePicture

  try {
    const user = await User.findByIdAndUpdate(
      userId,
      { bio, dateOfBirth }, // Only update bio and dateOfBirth
      { new: true }
    );
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json(user);
  } catch (error) {
    console.error("Error updating user profile:", error);
    res.status(500).json({ error: "Failed to update user profile" });
  }
});

// Get User Profile
router.get("/profile/:userId", async (req, res) => {
  const { userId } = req.params;

  try {
    const user = await User.findById(userId).select("-password");
    if (!user) {
      return res.status(404).json({ error: "User not found" });
    }
    res.json(user);
  } catch (error) {
    res.status(500).json({ error: "Failed to fetch user profile" });
  }
});

module.exports = router;

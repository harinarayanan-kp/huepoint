// routes/messageRoutes.js
const express = require('express');
const router = express.Router();
const Message = require('../models/Message');

// Send Message
router.post('/', async (req, res) => {
  const { content, sender, receiver } = req.body;

  if (!content || !sender || !receiver) {
    return res.status(400).json({ error: 'Content, sender, and receiver are required' });
  }

  try {
    const newMessage = new Message({ content, sender, receiver });
    const savedMessage = await newMessage.save();
    res.status(201).json(savedMessage);
  } catch (error) {
    res.status(500).json({ error: 'Failed to send message' });
  }
});

// Get Messages
router.get('/:senderId/:receiverId', async (req, res) => {
  const { senderId, receiverId } = req.params;

  try {
    const messages = await Message.find({
      $or: [
        { sender: senderId, receiver: receiverId },
        { sender: receiverId, receiver: senderId },
      ],
    }).exec();
    res.json(messages);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch messages' });
  }
});

module.exports = router;

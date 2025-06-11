// routes/groupRoutes.js
const express = require('express');
const Group = require('../models/Group');
const router = express.Router();

// Create a new group
router.post('/', async (req, res) => {
  try {
    const { name, description, members } = req.body;
    const group = new Group({ name, description, members });
    await group.save();
    res.status(201).send(group);
  } catch (error) {
    res.status(400).send({ error: error.message });
  }
});

// Get all groups
router.get('/', async (req, res) => {
  try {
    const groups = await Group.find().populate('members', 'name email');
    res.status(200).send(groups);
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

module.exports = router;

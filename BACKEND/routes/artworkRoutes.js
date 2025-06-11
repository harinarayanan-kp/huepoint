// routes/artworkRoutes.js
const express = require('express');
const Artwork = require('../models/Artwork');
const router = express.Router();

// Create a new artwork
router.post('/', async (req, res) => {
  try {
    const { title, description, imageUrl, price, artist } = req.body;
    const artwork = new Artwork({ title, description, imageUrl, price, artist });
    await artwork.save();
    res.status(201).send(artwork);
  } catch (error) {
    res.status(400).send({ error: error.message });
  }
});

// Get all artworks
router.get('/', async (req, res) => {
  try {
    const artworks = await Artwork.find().populate('artist', 'name email');
    res.status(200).send(artworks);
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

module.exports = router;

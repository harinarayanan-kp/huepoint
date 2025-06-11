// routes/orderRoutes.js
const express = require('express');
const Order = require('../models/Order');
const router = express.Router();

// Create a new order
router.post('/', async (req, res) => {
  try {
    const { artwork, buyer, quantity, totalPrice } = req.body;
    const order = new Order({ artwork, buyer, quantity, totalPrice });
    await order.save();
    res.status(201).send(order);
  } catch (error) {
    res.status(400).send({ error: error.message });
  }
});

// Get all orders
router.get('/', async (req, res) => {
  try {
    const orders = await Order.find().populate('artwork').populate('buyer', 'name email');
    res.status(200).send(orders);
  } catch (error) {
    res.status(500).send({ error: error.message });
  }
});

module.exports = router;

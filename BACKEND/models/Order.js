// models/Order.js
const mongoose = require('mongoose');

const orderSchema = new mongoose.Schema({
  artwork: { type: mongoose.Schema.Types.ObjectId, ref: 'Artwork', required: true },
  buyer: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  quantity: { type: Number, required: true },
  totalPrice: { type: Number, required: true },
  status: { type: String, enum: ['pending', 'completed', 'cancelled'], default: 'pending' },
  createdAt: { type: Date, default: Date.now }
});

const Order = mongoose.model('Order', orderSchema);
module.exports = Order;

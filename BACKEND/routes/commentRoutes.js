// routes/commentRoutes.js
const express = require('express');
const router = express.Router();
const Comment = require('../models/Comment');
const Post = require('../models/Post');

// Create Comment
router.post('/', async (req, res) => {
  const { content, author, postId } = req.body;

  if (!content || !author || !postId) {
    return res.status(400).json({ error: 'Content, author, and postId are required' });
  }

  try {
    const newComment = new Comment({ content, author, post: postId });
    const savedComment = await newComment.save();

    // Update the post's comments array
    await Post.findByIdAndUpdate(postId, { $push: { comments: savedComment._id } });

    res.status(201).json(savedComment);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create comment' });
  }
});

// Get Comments by Post ID
router.get('/post/:postId', async (req, res) => {
  const { postId } = req.params;

  try {
    const comments = await Comment.find({ post: postId }).populate('author').exec();
    res.json(comments);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch comments' });
  }
});

// Update Comment
router.put('/:commentId', async (req, res) => {
  const { commentId } = req.params;
  const { content } = req.body;

  try {
    const comment = await Comment.findByIdAndUpdate(commentId, { content }, { new: true });
    if (!comment) {
      return res.status(404).json({ error: 'Comment not found' });
    }
    res.json(comment);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update comment' });
  }
});

// Delete Comment
router.delete('/:commentId', async (req, res) => {
  const { commentId } = req.params;

  try {
    const comment = await Comment.findByIdAndDelete(commentId);
    if (!comment) {
      return res.status(404).json({ error: 'Comment not found' });
    }

    // Remove the comment from the post's comments array
    await Post.findByIdAndUpdate(comment.post, { $pull: { comments: commentId } });

    res.json({ message: 'Comment deleted successfully' });
  } catch (error) {
    res.status(500).json({ error: 'Failed to delete comment' });
  }
});

module.exports = router;

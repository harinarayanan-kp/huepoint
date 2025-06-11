// // routes/postRoutes.js
// const express = require('express');
// const User = require('../models/User');
// const authMiddleware = require('../middleware/authMiddleware');
// const router = express.Router();

// // Create a new post
// router.post('/', authMiddleware, async (req, res) => {
//   try {
//     const { description, imageUrl } = req.body;
//     const userId = req.userId;
//     console.log('Creating post for user ID:', userId); // Debugging statement
//     const user = await User.findById(userId);
//     if (!user) {
//       return res.status(404).send({ error: 'User not found' });
//     }
//     const post = { description, imageUrl, createdAt: Date.now(), username: user.name };
//     user.posts.push(post);
//     await user.save();
//     res.status(201).send(post);
//   } catch (error) {
//     console.error('Error creating post:', error); // Debugging statement
//     res.status(400).send({ error: error.message });
//   }
// });

// // Get all posts for the feed
// router.get('/feed', async (req, res) => {
//   try {
//     const posts = await User.aggregate([
//       { $unwind: '$posts' },
//       { $replaceRoot: { newRoot: '$posts' } },
//       { $sort: { createdAt: -1 } }
//     ]);
//     res.status(200).send(posts);
//   } catch (error) {
//     res.status(500).send({ error: error.message });
//   }
// });

// module.exports = router;


// routes/postRoutes.js
const express = require('express');
const router = express.Router();
const Post = require('../models/Post'); // Import the Post model

// Route to create a new post
router.post('/', async (req, res) => {
  const { title, content, imageUrl, author } = req.body;

  if (!title || !content || !author) {
    return res.status(400).json({ error: 'Title, content, and author are required' });
  }

  try {
    const newPost = new Post({
      title,
      content,
      imageUrl,
      author,
    });

    const savedPost = await newPost.save();
    res.status(201).json(savedPost);
  } catch (error) {
    res.status(500).json({ error: 'Failed to create post' });
  }
});

// Route to get all posts
router.get('/', async (req, res) => {
  try {
    const posts = await Post.find().populate('author').exec();
    res.json(posts);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch posts' });
  }
});

// Route to get a post by its ID
router.get('/:postId', async (req, res) => {
  const { postId } = req.params;

  try {
    const post = await Post.findById(postId).populate('author').exec();
    if (!post) {
      return res.status(404).json({ error: 'Post not found' });
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch post' });
  }
});


// Route to get all posts by a specific user ID
router.get('/user/:userId', async (req, res) => {
  const { userId } = req.params;

  try {
    const posts = await Post.find({ author: userId }).populate('author').exec();
    res.json(posts);
  } catch (error) {
    res.status(500).json({ error: 'Failed to fetch posts by user ID' });
  }
});

// Route to update a post
router.put('/:postId', async (req, res) => {
  const { postId } = req.params;
  const { title, content, imageUrl } = req.body;

  try {
    const post = await Post.findByIdAndUpdate(postId, { title, content, imageUrl }, { new: true }).populate('author').exec();
    if (!post) {
      return res.status(404).json({ error: 'Post not found' });
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Failed to update post' });
  }
});

// Route to like a post
router.post('/:postId/like', async (req, res) => {
  const { postId } = req.params;
  const { userId } = req.body;

  try {
    const post = await Post.findByIdAndUpdate(postId, { $addToSet: { likes: userId } }, { new: true }).populate('author').exec();
    if (!post) {
      return res.status(404).json({ error: 'Post not found' });
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Failed to like post' });
  }
});

// Route to unlike a post
router.post('/:postId/unlike', async (req, res) => {
  const { postId } = req.params;
  const { userId } = req.body;

  try {
    const post = await Post.findByIdAndUpdate(postId, { $pull: { likes: userId } }, { new: true }).populate('author').exec();
    if (!post) {
      return res.status(404).json({ error: 'Post not found' });
    }
    res.json(post);
  } catch (error) {
    res.status(500).json({ error: 'Failed to unlike post' });
  }
});

module.exports = router;

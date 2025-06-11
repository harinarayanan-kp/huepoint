import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String user;
  final String avatar;
  final String image;
  final String caption;
  final String likes;
  final String comments;
  final String time;

  const PostCard({
    super.key,
    required this.user,
    required this.avatar,
    required this.image,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.time,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isLiked = false;
  late int likeCount;

  @override
  void initState() {
    super.initState();
    likeCount = int.tryParse(widget.likes) ?? 0;
  }

  void _toggleLike() {
    setState(() {
      isLiked = !isLiked;
      likeCount += isLiked ? 1 : -1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      elevation: 6,
      shadowColor: Colors.black.withOpacity(0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.avatar),
              radius: 24,
            ),
            title: Text(
              widget.user,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.time),
            trailing: const Icon(Icons.more_vert),
          ),
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(0)),
                child: Image.network(
                  widget.image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 10,
                right: 16,
                child: GestureDetector(
                  onTap: _toggleLike,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              widget.caption,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _toggleLike,
                  child: Row(
                    children: [
                      Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 22,
                      ),
                      const SizedBox(width: 4),
                      Text('$likeCount'),
                    ],
                  ),
                ),
                const SizedBox(width: 18),
                const Icon(Icons.comment, color: Colors.blueGrey, size: 20),
                const SizedBox(width: 4),
                Text(widget.comments),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

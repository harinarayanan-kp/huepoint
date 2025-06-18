import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String user;
  final String avatar;
  final List<String> images;
  final String caption;
  final String likes;
  final String comments;
  final String time;

  const PostCard({
    super.key,
    required this.user,
    required this.avatar,
    required this.images,
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
  int currentImage = 0;
  final PageController _pageController = PageController();

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
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: const BorderSide(width: 2.0, color: Colors.black),
        ),
        shadows: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0,
            offset: Offset(3, 3),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 0),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.avatar),
              radius: 16,
            ),
            title: Text(
              widget.user,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            subtitle: Text(widget.time, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.more_vert, size: 20),
            dense: true,
          ),
          // Image carousel with action buttons overlay
          Stack(
            children: [
              SizedBox(
                width: double.infinity,
                height: 220,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (i) {
                    setState(() {
                      currentImage = i;
                    });
                  },
                  itemBuilder: (context, i) => Image.network(
                    widget.images[i],
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Image number indicator (bottom left)
              Positioned(
                left: 12,
                bottom: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: Colors.black.withOpacity(0.5),
                  child: Text(
                    '${currentImage + 1} / ${widget.images.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),
              ),
              // Action buttons (bottom right)
              Positioned(
                right: 8,
                bottom: 8,
                child: Column(
                  children: [
                    IconButton(
                      icon: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.red : Colors.white,
                      ),
                      onPressed: _toggleLike,
                      tooltip: 'Like',
                      splashRadius: 22,
                    ),
                    Text(
                      '$likeCount',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    IconButton(
                      icon: const Icon(Icons.comment, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comment tapped!')),
                        );
                      },
                      tooltip: 'Comment',
                      splashRadius: 22,
                    ),
                    Text(
                      widget.comments,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        shadows: [Shadow(blurRadius: 2, color: Colors.black)],
                      ),
                    ),
                    const SizedBox(height: 4),
                    IconButton(
                      icon: const Icon(Icons.share, color: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Share tapped!')),
                        );
                      },
                      tooltip: 'Share',
                      splashRadius: 22,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              widget.caption,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

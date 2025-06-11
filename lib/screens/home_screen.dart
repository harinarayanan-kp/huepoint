import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:huepoint/components/post_card.dart';
import 'package:huepoint/components/profile_card.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7ED),
      appBar: AppBar(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/images/huepoint.svg',
          ),
        ),
        title: Text(
          'huepoint',
          style: GoogleFonts.righteous(
            fontSize: 24,
            color: Colors.black, // Ensure the text color contrasts with the background
          ),
          overflow: TextOverflow.ellipsis, // Handle text overflow
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/notification-new.svg',
              height: 30,
              width: 30,
            ), // Notification icon
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/comment-typing.svg',
              height: 30,
              width: 30,
            ), // Inbox icon
            onPressed: () {
              Navigator.pushNamed(context, '/inbox');
            },
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 234, 7),
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/post');
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Create Post'),
                ),
              ),
              const SizedBox(height: 20),
              // Dummy Feed
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  final posts = [
                    {
                      'user': 'Alice',
                      'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
                      'image':
                          'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80',
                      'caption': 'A beautiful sunset at the lake!',
                      'likes': '120',
                      'comments': '15',
                      'time': '2h ago',
                    },
                    {
                      'user': 'Bob',
                      'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
                      'image':
                          'https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80',
                      'caption': 'Exploring the mountains.',
                      'likes': '98',
                      'comments': '8',
                      'time': '3h ago',
                    },
                    {
                      'user': 'Clara',
                      'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
                      'image':
                          'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=crop&w=400&q=80',
                      'caption': 'Ocean vibes 🌊',
                      'likes': '143',
                      'comments': '22',
                      'time': '5h ago',
                    },
                  ];
                  final post = posts[index];
                  return PostCard(
                    user: post['user']!,
                    avatar: post['avatar']!,
                    image: post['image']!,
                    caption: post['caption']!,
                    likes: post['likes']!,
                    comments: post['comments']!,
                    time: post['time']!,
                  );
                },
              ),
              const SizedBox(height: 10),
              // Recommended artists
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8, top: 8),
                child: Text(
                  'Recommended artists',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.only(left: 20, bottom: 20),
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    Profilecard(),
                    Profilecard(),
                    Profilecard(),
                    Profilecard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

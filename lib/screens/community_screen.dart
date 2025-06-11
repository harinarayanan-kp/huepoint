import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> communities = [
      {
        'name': 'Art Lovers',
        'desc': 'Share and discuss your favorite artworks.',
        'image': 'https://img.icons8.com/color/96/paint-palette.png'
      },
      {
        'name': 'Photography',
        'desc': 'A place for shutterbugs and photo critiques.',
        'image': 'https://img.icons8.com/color/96/camera--v2.png'
      },
      {
        'name': 'Digital Artists',
        'desc': 'Showcase your digital creations and get feedback.',
        'image': 'https://img.icons8.com/color/96/drawing.png'
      },
      {
        'name': 'Street Art',
        'desc': 'Discuss graffiti, murals, and urban art.',
        'image': 'https://img.icons8.com/color/96/street-art.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities'),
        backgroundColor: const Color.fromARGB(255, 255, 234, 7),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 250, 248, 215),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: communities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final community = communities[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            elevation: 3,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(community['image']!),
                radius: 28,
              ),
              title: Text(
                community['name']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                community['desc']!,
                style: const TextStyle(fontSize: 14),
              ),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 234, 7),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Joined "${community['name']}"!')),
                  );
                },
                child: const Text('Join'),
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {
        'title': 'New follower!',
        'body': 'Alice started following you.',
        'time': '2m ago',
      },
      {
        'title': 'Comment received',
        'body': 'Bob commented on your post.',
        'time': '10m ago',
      },
      {
        'title': 'Art Sold!',
        'body': 'Congrats! Your artwork "Sunset Bliss" was sold.',
        'time': '1h ago',
      },
      {
        'title': 'Community Invite',
        'body': 'You were invited to join "Digital Artists".',
        'time': '2h ago',
      },
      {
        'title': 'Like received',
        'body': 'Clara liked your post.',
        'time': '3h ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: const Color.fromARGB(255, 255, 234, 7),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 250, 248, 215),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.amber, size: 32),
              title: Text(
                notif['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(notif['body']!),
              trailing: Text(
                notif['time']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}

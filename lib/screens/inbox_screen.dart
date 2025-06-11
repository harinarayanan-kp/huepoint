import 'package:flutter/material.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {
        'user': 'Alice',
        'avatar': 'https://randomuser.me/api/portraits/women/1.jpg',
        'lastMessage': 'Hey! How are you?',
        'time': '2m ago',
      },
      {
        'user': 'Bob',
        'avatar': 'https://randomuser.me/api/portraits/men/2.jpg',
        'lastMessage': 'Check out my new artwork!',
        'time': '10m ago',
      },
      {
        'user': 'Clara',
        'avatar': 'https://randomuser.me/api/portraits/women/3.jpg',
        'lastMessage': 'Let\'s collab soon!',
        'time': '1h ago',
      },
      {
        'user': 'David',
        'avatar': 'https://randomuser.me/api/portraits/men/4.jpg',
        'lastMessage': 'Thanks for the feedback!',
        'time': '2h ago',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        backgroundColor: const Color.fromARGB(255, 255, 234, 7),
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 250, 248, 215),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: chats.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(chat['avatar']!),
                radius: 26,
              ),
              title: Text(
                chat['user']!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(chat['lastMessage']!),
              trailing: Text(
                chat['time']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Open chat with ${chat['user']}')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

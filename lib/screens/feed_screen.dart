import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:huepoint/screens/post_screen.dart';
import 'package:huepoint/screens/profile_screen.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    final response = await http.get(Uri.parse('http://localhost:5000/api/posts/feed'));
    if (response.statusCode == 200) {
      setState(() {
        _posts = jsonDecode(response.body);
      });
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          final post = _posts[index];
          return ListTile(
            leading: post['imageUrl'] != null ? Image.network(post['imageUrl']) : Icon(Icons.image),
            title: Text(post['description']),
            subtitle: Text('By ${post['username']}'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profilescreen()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreatePostScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

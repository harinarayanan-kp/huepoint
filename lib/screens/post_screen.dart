import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  Future<void> _createPost() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // Handle missing token
      print('Error: No token found');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No token found')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/posts'), // Update the URL to localhost
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'description': _descriptionController.text,
          'imageUrl': _imageUrlController.text,
        }),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
      } else {
        // Handle error
        print('Error: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to create post: ${response.body}')),
        );
      }
    } catch (error) {
      // Handle network or other errors
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create post: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPost,
              child: Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}

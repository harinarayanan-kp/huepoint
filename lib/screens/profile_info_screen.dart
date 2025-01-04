import 'package:flutter/material.dart';
import 'package:huepoint/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfoScreen extends StatefulWidget {
  @override
  _ProfileInfoScreenState createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  File? _profilePicture;
  final ImagePicker _picker = ImagePicker();
  final AuthService _authService = AuthService();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profilePicture = File(pickedFile.path);
      });
    }
  }

  // Future<void> _completeProfile() async {
  //   final prefsDATA = SharedPreferences.getInstance();
  //   print('USER ID = $prefsDATA.getString[]');
  //   final userId = 'user-id'; // Replace with the actual user ID
  //   final updatedData = {
  //     'bio': _bioController.text,
  //     'dateOfBirth': _dobController.text,
  //     'profilePicture': _profilePicture != null ? _profilePicture!.path : '',
  //   };

  //   try {
  //     await _authService.updateUserProfile(userId, updatedData);
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } catch (e) {
  //     print('Error: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to update profile: $e')),
  //     );
  //   }
  // }

  Future<void> _completeProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User ID not found')),
      );
      return;
    }

    final updatedData = {
      'bio': _bioController.text,
      'dateOfBirth': _dobController.text,
      'profilePicture': _profilePicture != null ? _profilePicture!.path : '',
    };

    try {
      await _authService.updateUserProfile(userId, updatedData);
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update profile: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 248, 215),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 234, 7),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'COMPLETE YOUR PROFILE',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePicture != null ? FileImage(_profilePicture!) : null,
                  child: _profilePicture == null ? const Icon(Icons.add_a_photo, size: 50) : null,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _dobController,
                decoration: const InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.amberAccent,
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    _dobController.text = pickedDate.toLocal().toString().split(' ')[0];
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _completeProfile,
                child: const Text('Complete Profile'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/home');
                },
                child: const Text('Skip'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

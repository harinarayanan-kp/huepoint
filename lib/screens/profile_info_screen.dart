import 'package:flutter/material.dart';
import 'package:huepoint/services/auth_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

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
      print('Updating user with userId: $userId');
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 234, 7),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: const Text(
                      'COMPLETE YOUR PROFILE',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.white,
                          backgroundImage: _profilePicture != null ? FileImage(_profilePicture!) : null,
                          child:
                              _profilePicture == null ? const Icon(Icons.person, size: 60, color: Colors.grey) : null,
                        ),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 234, 7),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.camera_alt, size: 22, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  _roundedTextField(
                    controller: _bioController,
                    label: 'Bio',
                    icon: Icons.info_outline,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      FocusScope.of(context).unfocus();
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
                    child: AbsorbPointer(
                      child: _roundedTextField(
                        controller: _dobController,
                        label: 'Date of Birth',
                        icon: Icons.cake_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 234, 7),
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      onPressed: _completeProfile,
                      child: const Text('Complete Profile'),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    child: const Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _roundedTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color.fromARGB(255, 255, 234, 7), width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}

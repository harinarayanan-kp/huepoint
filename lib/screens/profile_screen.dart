import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huepoint/components/custom_button.dart';
import 'package:huepoint/screens/login_screen.dart';
import 'package:huepoint/services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final AuthService _authService = AuthService();

  void _logout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  Future<Map<String, dynamic>> _fetchUserDetails() async {
    String? name = await _authService.getUserName();
    String? email = await _authService.getUserEmail();
    String? username = await _authService.getUserUserName();
    Map<String, dynamic>? details = await _authService.getUserDetails();
    print("DATA= $details");
    return {
      'name': name,
      'email': email,
      'username': username,
      'profilePicture': details?['profilePicture'],
      'bio': details?['bio'],
      'dateOfBirth': details?['dateOfBirth'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error _fetchUserDetails: ${snapshot.error}'));
        } else {
          final userDetails = snapshot.data!;
          return Stack(
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        color: const Color.fromARGB(255, 142, 145, 147),
                      ),
                      Positioned(
                        top: 130,
                        left: MediaQuery.of(context).size.width / 2 - 75, // centers the image
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image(
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            image:
                                NetworkImage('https://i.pinimg.com/236x/6a/c7/80/6ac780f0649e8e2497148d50edf432c3.jpg'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 90), // Add space for the overlapping image
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              userDetails['name'] ?? '',
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: 10),
                            SvgPicture.asset(
                              'assets/images/verified_badge.svg',
                              height: 30,
                              width: 30,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '@${userDetails['username'] ?? ''}',
                          style: const TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          ' ${userDetails['email'] ?? ''}',
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Bio: ${userDetails['bio'] ?? ''}',
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Date of Birth: ${userDetails['dateOfBirth'] ?? ''}',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                    label: 'LOGOUT',
                    onPressed: () => _logout(context),
                  ),
                  CustomButton(
                    label: 'Create POST',
                    onPressed: () => Navigator.pushNamed(context, '/post'),
                  ),
                  CustomButton(
                    label: 'View Post',
                    onPressed: () => Navigator.pushNamed(context, '/feed'),
                  ),
                  CustomButton(
                    label: 'Edit Profile',
                    onPressed: () => Navigator.pushNamed(context, '/profile-info'),
                  )
                ],
              ),
              // Settings icon at top right
              Positioned(
                top: 16,
                right: 16,
                child: IconButton(
                  icon: const Icon(Icons.settings, size: 32, color: Colors.white),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  tooltip: 'Settings',
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

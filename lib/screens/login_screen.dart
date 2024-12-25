import 'package:flutter/material.dart';
import 'package:huepoint/screens/forgot_password_screen.dart';
import 'package:huepoint/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _performLogin() {
    // final username = _usernameController.text;
    // final password = _passwordController.text;
    print('Username: \$username, Password: \$password');
    // Add your login logic here
    Navigator.pushNamed(context, '/home');
  }

  void _navigateToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
    );
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 32.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: _performLogin,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _navigateToForgotPassword,
              child: const Text('Forgot Password?'),
            ),
            TextButton(
              onPressed: _navigateToSignUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:huepoint/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final AuthService _authService = AuthService();
  String _passwordStrength = '';
  final ValueNotifier<bool> _isPasswordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<String> _passwordNotifier = ValueNotifier<String>('');

  Future<void> _signup() async {
    if (_passwordController.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters long')),
      );
      return;
    }

    final passwordStrength = _checkPasswordStrength(_passwordController.text);
    if (passwordStrength == 'your password is too weak') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password is too weak. Please include special characters, capital letters, or numbers.')),
      );
      return;
    }

    try {
      final response = await _authService.signup(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _usernameController.text,
      );
      Navigator.pushReplacementNamed(context, '/profile-info');
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to sign up: $e')),
      );
    }
  }

  String _checkPasswordStrength(String password) {
    bool hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowerCase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

    if (hasUpperCase && hasLowerCase && hasDigits && hasSpecialCharacters) {
      return 'Strong Password';
    } else if ((hasUpperCase || hasLowerCase) && (hasDigits || hasSpecialCharacters)) {
      return 'Make it Stronger';
    } else {
      return 'your password is too weak';
    }
  }

  Color _getPasswordStrengthColor(String strength) {
    switch (strength) {
      case 'your password is too weak':
        return Colors.red;
      case 'Make it Stronger':
        return const Color.fromARGB(255, 117, 107, 25);
      case 'Strong Password':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
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
              SvgPicture.asset(
                'assets/images/happy.svg',
                height: 200,
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 234, 7),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.amberAccent,
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<String>(
                valueListenable: _passwordNotifier,
                builder: (context, password, child) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isPasswordVisible,
                    builder: (context, isVisible, child) {
                      return TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: const OutlineInputBorder(),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          suffixIcon: password.isNotEmpty
                              ? IconButton(
                                  icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                                  onPressed: _togglePasswordVisibility,
                                )
                              : null,
                        ),
                        obscureText: !isVisible,
                        onChanged: (value) {
                          _passwordNotifier.value = value;
                          setState(() {
                            _passwordStrength = _checkPasswordStrength(value);
                          });
                        },
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                _passwordStrength,
                style: TextStyle(fontSize: 16, color: _getPasswordStrengthColor(_passwordStrength)),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: const Text('Signup'),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

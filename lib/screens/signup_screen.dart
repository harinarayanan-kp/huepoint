import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:huepoint/services/auth_service.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

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
      await _authService.signup(
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
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/happy.svg',
                  height: 140,
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 234, 7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: const Text(
                    'SIGN UP',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                _roundedTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 18),
                _roundedTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 18),
                _roundedTextField(
                  controller: _usernameController,
                  label: 'Username',
                  icon: Icons.alternate_email,
                ),
                const SizedBox(height: 18),
                ValueListenableBuilder<String>(
                  valueListenable: _passwordNotifier,
                  builder: (context, password, child) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: _isPasswordVisible,
                      builder: (context, isVisible, child) {
                        return _roundedTextField(
                          controller: _passwordController,
                          label: 'Password',
                          icon: Icons.lock_outline,
                          obscureText: !isVisible,
                          suffixIcon: password.isNotEmpty
                              ? IconButton(
                                  icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                                  onPressed: _togglePasswordVisibility,
                                )
                              : null,
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
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _passwordStrength,
                    style: TextStyle(fontSize: 15, color: _getPasswordStrengthColor(_passwordStrength)),
                  ),
                ),
                const SizedBox(height: 24),
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
                    onPressed: _signup,
                    child: const Text('Signup'),
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Google signup coming soon!')),
                      );
                    },
                    icon: Image.asset(
                      'assets/images/google.png',
                      height: 24,
                    ),
                    label: const Text(
                      'Signup with Google',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ],
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
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
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
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}

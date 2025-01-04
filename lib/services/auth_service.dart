import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AuthService {
  // final String baseUrl = 'https://huepoint-backend.vercel.app/api/auth';
  final String baseUrl = 'http://localhost:5000/api/auth';

  Future<Map<String, dynamic>> signup(String name, String email, String password, String username) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password, 'username': username}),
      );
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        await _saveToken(data['token']);

        // Check if user ID is included in the response
        if (data['user'] != null && data['user']['_id'] != null) {
          await _saveUserId(data['user']['_id']);
        } else {
          throw Exception('User ID not found in the response');
        }

        // Check if user details are included in the response
        if (data.containsKey('user')) {
          await _saveUserDetails(data['user']);
        } else {
          // Save user details manually
          await _saveUserDetails({'name': name, 'email': email, 'username': username});
        }

        return data;
      } else {
        throw Exception('Signup failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Signup failed: $e');
    }
  }
  // Future<Map<String, dynamic>> signup(String name, String email, String password, String username) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/signup'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'name': name, 'email': email, 'password': password, 'username': username}),
  //   );

  //   if (response.statusCode == 201) {
  //     final responseData = jsonDecode(response.body);
  //     // Save the token, username, and email in SharedPreferences
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', responseData['token']);
  //     await prefs.setString('userId', responseData['user']['_id']);
  //     await prefs.setString('username', responseData['user']['username']);
  //     await prefs.setString('email', responseData['user']['email']);
  //     return responseData;
  //   } else {
  //     throw Exception('Signup failed: ${response.body}');
  //   }
  // }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveToken(data['token']);

        // Check if user details are included in the response
        if (data.containsKey('user')) {
          await _saveUserDetails(data['user']);
        } else {
          // Fetch user details from the database
          final userDetails = await _fetchUserDetails(email);
          await _saveUserDetails(userDetails);
        }

        return data;
      } else {
        throw Exception('Login failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  Future<void> updateUserProfile(String userId, Map<String, dynamic> updatedData) async {
    final url = '$baseUrl/user/$userId';
    final request = http.MultipartRequest('PUT', Uri.parse(url));
    request.headers['Authorization'] = 'Bearer ${await getToken()}';

    // Add fields to the request
    request.fields['bio'] = updatedData['bio'];
    request.fields['dateOfBirth'] = updatedData['dateOfBirth'];

    // Add file to the request if available
    if (updatedData['profilePicture'] != null && updatedData['profilePicture'] != '') {
      request.files.add(await http.MultipartFile.fromPath('profilePicture', updatedData['profilePicture']));
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final updatedUser = jsonDecode(await response.stream.bytesToString());
      await _saveUserDetails(updatedUser);
    } else {
      throw Exception('Failed to update user profile: ${response.reasonPhrase}');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> _saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> _saveUserDetails(Map<String, dynamic> userDetails) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userDetails['name']);
    await prefs.setString('userUserName', userDetails['username']);
    await prefs.setString('userEmail', userDetails['email']);
  }

  Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userName');
    return name;
  }

  Future<String?> getUserUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('userUserName');
    return name;
  }

  Future<String?> getUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');
    return email;
  }

  Future<Map<String, dynamic>?> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final userDetailsString = prefs.getString('userDetails');
    if (userDetailsString != null) {
      return jsonDecode(userDetailsString);
    }
    return null;
  }

  Future<Map<String, dynamic>> _fetchUserDetails(String email) async {
    final response = await http.get(
      Uri.parse('https://huepoint-backend.vercel.app/api/user/userDetails?email=$email'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user details: ${response.body}');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('userName');
    await prefs.remove('userEmail');
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'http://localhost:3000/api/auth';

  static Future<String> loginUser(String username, String password) async {
    final url = Uri.parse('$baseUrl/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return body['message'] ?? 'Login successful';
    } else {
      return body['error'] ?? 'Login failed';
    }
  }

  static Future<String> registerUser(String username, String password, String pin) async {
    final url = Uri.parse('$baseUrl/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'pin': pin,
      }),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return body['message'] ?? 'Registration successful';
    } else {
      return body['error'] ?? 'Registration failed';
    }
  }

  static Future<bool> verifyPin(String username, String pin) async {
    final url = Uri.parse('$baseUrl/verify-pin');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'pin': pin,
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return body['valid'] == true;
    }

    return false;
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  static String baseUrl = 'http://192.168.58.82:3000';

  static Future<Map<String, String>> getHeaders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  Future<dynamic> getRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/$endpoint'),
          headers: await getHeaders());
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load $endpoint');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<T> postRequest<T>(String endpoint, Map<dynamic, dynamic> body) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: await getHeaders(),
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to post to $endpoint');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}

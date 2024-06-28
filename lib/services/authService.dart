import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String? tokens;
  Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    return token;
  }

  returnToken() async {
    tokens = await getToken();
    return (tokens); // Use tokens here after it's retrieved
  }

  checkAuth(token) async {
    if (token == null) {
      return (false);
    }
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.6:8000/api/auth'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse['status']) {
          setUser(jsonResponse);

          return (true);
        } else {
          return (false);
        }
      } else {
        return (false);
      }
    } catch (e) {
      return (false);
    }
  }



// clearAuthSession
  Future<void> setIsAuth(isAuth) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthS', isAuth);
  }

// setUser
  Future<void> setUser(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', [jsonEncode(userData)]);
  }

  Future<Map<String, dynamic>?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('user');
    if (userStrings != null && userStrings.isNotEmpty) {
      return jsonDecode(userStrings[0]);
    } else {
      print('No user data found');
      return null;
    }
  }
}

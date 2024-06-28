import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterproject/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EditAccountPage(),
    );
  }
}

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final AuthService authService = AuthService();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String? token;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  Future<void> _getToken() async {
    token = await authService.returnToken();
  }

  Future<void> editUser(BuildContext context) async {
    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.5:8000/api/editUserProfile'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode(<String, String>{
              'mobile': _mobileController.text,
              'email': _emailController.text,
              'name': _nameController.text,
            }),
          )
          .timeout(const Duration(seconds: 30)); // Increased timeout duration

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status']) {
          setState(() {
            token = data['user']['access_token'];
          });

          _showDialog(
            context,
            'Update successful',
            'You are now logged in.',
          );

        } else {
          _showDialog(context, 'Update failed', data['message']);
        }
      } else {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _showDialog(context, 'Update failed', data['message']);
      }
    } catch (e) {
      _showDialog(context, 'Error', e.toString());
    }
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Account'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: InkWell(
        onTap: () async {
          String? token = await authService.returnToken();
          print(token);
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
              ),
              const Text(
                'Full Name *',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Container(
                height: 10,
              ),
              Container(
                height: 70,
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Email *',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Container(
                height: 10,
              ),
              Container(
                height: 70,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Mobile *',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Container(
                height: 10,
              ),
              Container(
                height: 70,
                child: TextField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                    hintText: "Mobile",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                height: 55,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    editUser(context);
                  },
                  child: Container(
                    width: 400,
                    height: 70,
                    decoration: BoxDecoration(
                      color: const Color(0xffECC402),
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                    ),
                    child: const Center(
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 90,
              ),
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 228, 220, 220),
                  borderRadius: BorderRadius.circular(
                      15), // Adjust the radius value as needed
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: const Text(
                        "Terminate Account",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: SvgPicture.asset(
                        'assets/images/myaccount/delete.svg',
                        width: 91,
                        height: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

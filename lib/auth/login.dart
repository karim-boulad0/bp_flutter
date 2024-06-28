import 'package:flutter/material.dart';
import 'package:flutterproject/auth/signup.dart';
import 'package:flutterproject/homePage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
// variables----------------------------------------------
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // setTheIsAuth
  Future<void> setTheIsAuth(BoolV) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuth', BoolV);
  }

// setToken
  Future<void> setToken(token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

// storeUser
  Future<void> setUser(Map<String, dynamic> userData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', [jsonEncode(userData)]);
  }

  Future<void> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? userStrings = prefs.getStringList('user');
    if (userStrings != null && userStrings.isNotEmpty) {
      // Assuming the first item in the list is the JSON string of the user data
      var user = jsonDecode(userStrings[0]);
      print(user['id']);
    } else {
      print('No user data found');
    }
  }

  Future<void> getTheIsAuth() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getBool('isAuth');
    bool? auth = prefs.getBool('isAuth');
    if (auth == true || auth!) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  void initState() {
    getTheIsAuth();
    super.initState();
  }

  String? token;
  Future<void> checkAuth() async {
    if (token == null) {
      setTheIsAuth(false);
      print(
          '#############################################################################3');
      print('Token is not available. Please login first.');
      print(
          '#############################################################################3');
      return;
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
        setState(() {
          setUser(jsonResponse['message']);
        });
        if (jsonResponse['status']) {
          setToken(token);
          setTheIsAuth(true);
          print(
              '#############################################################################3');
          print('Auth successful: ${jsonResponse['message']}');

          print("value of isAuth########################################3");
          print(
              '#############################################################################3');
        } else {
          print(
              '#############################################################################3');
          print('Auth failed: ${jsonResponse['message']}');
          print(
              '#############################################################################3');
        }
      } else {
        setTheIsAuth(false);
        print(
            '#############################################################################3');
        print('Failed to authenticate. Status code: ${response.statusCode}');
        print(
            '#############################################################################3');
      }
    } catch (e) {
      setTheIsAuth(false);
      print(
          '#############################################################################3');
      print('Error occurred: $e');
      print(
          '#############################################################################3');
    }
  }

  void login(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.6:8000/api/login'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 30)); // Increased timeout duration

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status']) {
          setState(() {
            token = data['user']['access_token'];
          });

          // Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(builder: (context) => const HomePage()));
          setTheIsAuth(true);

          checkAuth();
          _showDialog(
            context,
            'Login successful',
            'You are now logged in.',
          );
        } else {
          setTheIsAuth(false);

          _showDialog(context, 'Login failed', data['message']);
        }
      } else {
        setTheIsAuth(false);

        final Map<String, dynamic> data = jsonDecode(response.body);
        _showDialog(context, 'Login failed', data['message']);
      }
    } catch (e) {
      setTheIsAuth(false);

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

//end  variables------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        // ignore: avoid_unnecessary_containers
        body: Container(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(70))),
                      child: Image.asset(
                        'assets/images/auth/logo.png',
                        width: 40,
                        height: 40,
                        // fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  const Text("Login",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                  Container(
                    height: 10,
                  ),
                  const Text("Login To Continue The App",
                      style: TextStyle(color: Colors.grey)),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    "Email",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(color: Colors.grey, fontSize: 17),
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(40)),
                        filled: true,
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        hintText: "Enter Your Email"),
                  ),
                  Container(
                    height: 15,
                  ),
                  const Text(
                    "Password",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Container(
                    height: 16,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 17), // This sets the input text color to grey
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        filled: true,
                        hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors
                                .grey), // This sets the hint text color to grey
                        hintText: "Enter Your Password"),
                  ),
                  Container(
                    height: 20,
                  ),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Forget Password?',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  MaterialButton(
                    color: const Color.fromARGB(255, 8, 35, 233),
                    minWidth: 500,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(15),
                    textColor: Colors.white,
                    onPressed: () {
                      login(context);
                      getTheIsAuth();
                    },
                    child: const Text("Login"),
                  ),
                  Container(
                    height: 10,
                  ),
                  MaterialButton(
                    color: const Color.fromARGB(255, 24, 49, 119),
                    minWidth: 500,
                    height: 40,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.all(15),
                    textColor: Colors.white,
                    onPressed: () {},
                    child: InkWell(
                      onTap: () {
                        print("####################################trappppp");
                        getUser();
                        print("####################################trappppp");
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Login With Google",
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                              width:
                                  8), // Add a SizedBox with the desired width to create a gap
                          Image.asset(
                            width: 20,
                            height: 20,
                            'assets/images/auth/google.png',
                            fit: BoxFit.fill,
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Signup()));
                    },
                    child: const Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: "Don't Have An Account? "),
                            TextSpan(
                              text: "Register",
                              style: TextStyle(
                                color: Color.fromARGB(255, 33, 17, 100),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

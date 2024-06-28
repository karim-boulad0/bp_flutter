import 'package:flutter/material.dart';
import 'package:flutterproject/auth/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Forget extends StatefulWidget {
  const Forget({super.key});
  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> with SingleTickerProviderStateMixin {
// variables----------------------------------------------

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void Forget(BuildContext context) async {
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final response = await http
          .post(
            Uri.parse('http://192.168.1.5:8000/api/Forget'),
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
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("dddddddddddddddddddddddddddddddddddddddddddddd");
        print(responseData);
        print("dddddddddddddddddddddddddddddddddddddddddddddd");
        if (responseData['status']) {
          _showErrorDialog(
              // ignore: use_build_context_synchronously
              context,
              'Forget successful',
              'Status code: Forget successful');
        } else {
          // ignore: avoid_print
          print("Forget failed");
          // ignore: use_build_context_synchronously
          _showErrorDialog(context, 'Forget failed',
              'Status code: ${responseData['message']}');
        }
      } else {
                final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("ddddddddddddddddddddddddddddddddddddddddddddddnot2000");
        print(responseData);
        print("ddddddddddddddddddddddddddddddddddddddddddddddnot2000");
        // ignore: use_build_context_synchronously
        _showErrorDialog(context, 'Forget failed',
            'Status code: ${response.statusCode}\nBody: ${response.body}');
      }
    } catch (e) {
      // ignore: avoid_print
      print("Error during Forget: $e");
      // ignore: use_build_context_synchronously
      _showErrorDialog(context, 'Error', e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String title, String message) {
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
                  const Text("Forget",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 27)),
                  Container(
                    height: 10,
                  ),
                  const Text("Forget To Continue The App",
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
                      Forget(context);

                      print(
                          "##################################################333333333");
                      print(emailController.text);
                      print(
                          "##################################################333333333");
                      print(passwordController.text);
                      print(
                          "##################################################333333333");
                    },
                    child: const Text("Forget"),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Forget With Google",
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

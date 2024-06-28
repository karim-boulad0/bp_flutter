import 'package:flutter/material.dart';
import 'package:flutterproject/auth/forget.dart';
import 'package:flutterproject/auth/login.dart';
import 'package:flutterproject/auth/signup.dart';
import 'package:flutterproject/components/myaccount/myAccount.dart';
import 'package:flutterproject/homePage.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // Connets your flutter project with firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "HomePage": (context) => const HomePage(),
        "MyAccount": (context) =>  MyAccount(),
        "LoginPage": (context) => const Login(),
        "Signup": (context) => const Signup(),
        "Forget": (context) => const Forget(),
      },
      theme: ThemeData(
        fontFamily: "PlayfairDisplay",
        textTheme: const TextTheme(
          
          bodySmall: TextStyle(color: Colors.blue, fontSize: 14),
          bodyMedium: TextStyle(color: Colors.black, fontSize: 16),
          bodyLarge: TextStyle(
              color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const HomePage(),
    );
  }
}

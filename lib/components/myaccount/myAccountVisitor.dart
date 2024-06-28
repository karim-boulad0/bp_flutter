import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterproject/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyAccountVisitor extends StatefulWidget {
  @override
  _MyAccountVisitorState createState() => _MyAccountVisitorState();
}

class _MyAccountVisitorState extends State<MyAccountVisitor> {
  bool isAuthenticated = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    
    return Container(
      child: Padding(
        padding: EdgeInsets.all(22),
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () async {
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffECC402),
                    ),
                    alignment: Alignment.center,
                    width: 170,
                    height: 50,
                    child: const Text(
                      "Sign In",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Container(
                  alignment: Alignment.center,
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 148, 125, 7),
                  ),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 92, 90, 90)),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(top: 25),
            height: 130,
            width: 360,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: const Icon(
                                  Icons.notifications_active_outlined,
                                  size: 30,
                                ),
                              ),
                              const Text("Notifications")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Switch(
                            // This bool value toggles the switch.
                            value: isAuthenticated,
                            inactiveThumbColor: Colors.black,
                            activeTrackColor: Colors.green,
                            activeColor: Colors.white,
                            onChanged: (bool value) {
                              // This is called when the user toggles the switch.
                              setState(() {
                                isAuthenticated = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            // ignore: avoid_unnecessary_containers
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              child: const Icon(
                                Icons.language_outlined,
                                size: 30,
                              ),
                            ),
                            const Text("Language")
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("English"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 50),
            child: const Text(
              "Support",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 92, 90, 90)),
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(top: 25),
            height: 220,
            width: 360,
            child: Column(
              children: [
                // start------------------------------------------------
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  'assets/images/myaccount/b.svg',
                                  width: 91,
                                  height: 28,
                                ),
                              ),
                              const Text("About Best Price")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/myaccount/arch.svg',
                            width: 30,
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 10,
                ),

                // end-------------------
                // start------------------------------------------------
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  'assets/images/myaccount/pepare.svg',
                                  width: 91,
                                  height: 28,
                                ),
                              ),
                              const Text("Our Policies")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/myaccount/arch.svg',
                            width: 30,
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),

                // end-------------------
                // start------------------------------------------------
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  'assets/images/myaccount/pepare.svg',
                                  width: 91,
                                  height: 28,
                                ),
                              ),
                              const Text("Terms & Conditions")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/myaccount/arch.svg',
                            width: 30,
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                ),

                // end-------------------
                // start------------------------------------------------
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              // ignore: avoid_unnecessary_containers
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: SvgPicture.asset(
                                  'assets/images/myaccount/headphone.svg',
                                  width: 91,
                                  height: 28,
                                ),
                              ),
                              const Text("Contact Us")
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          SvgPicture.asset(
                            'assets/images/myaccount/arch.svg',
                            width: 30,
                            height: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // end-------------------
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Text("V.1.0"),
          ),
          Container(
            alignment: Alignment.center,
            child: Text("© 2023 Best Price. All rights reserved"),
          ),
          Container(
            alignment: Alignment.center,
            child: Text("Powered By Line"),
          )
        ]),
      ),
    );
  }
}

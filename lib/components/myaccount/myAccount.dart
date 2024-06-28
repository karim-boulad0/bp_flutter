import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutterproject/services/authService.dart';
import 'package:flutterproject/user/editAccount.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isAuthenticated = false;
  AuthService authService = AuthService();
  Map<String, dynamic>? user;

  userData() async {
    var response = await authService.getUser();
    setState(() {
      user = response?['message'];
    });
  }

  @override
  void initState() {
    super.initState();
    userData();
  }

// ---------------------
// ---------------------
  bool isAuthenticated1 = false;
  String? token;

  _handleAuth() async {
    token = await authService.returnToken();
    bool authResult =
        await authService.checkAuth(token); // Wait for checkAuth to complete
    setState(() {
      authService.setIsAuth(authService);
      isAuthenticated1 =
          authResult; // Update isAuthenticated1 based on the awaited result
    });
     userData();
  }

// ---------------------
// ---------------------
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers

    return user == null
        ? InkWell(
            onTap: () async {
            },
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : InkWell(
            onTap: ()async {
                            return await _handleAuth();

            },
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: ListView(children: [
                  // ignore: avoid_unnecessary_containers

                  // ignore: avoid_unnecessary_containers
                  InkWell(
                    onTap: () {
                      userData();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(255, 92, 90, 90)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.only(top: 25),
                      height: 140,
                      width: 360,
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user!['name'] ?? '',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user!['email'] ?? '',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  user!['mobile'] ?? '',
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Text(
                      "My Account",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 92, 90, 90)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: const EdgeInsets.only(top: 25),
                    height: 300,
                    width: 360,
                    child: Column(
                      children: [
                        // start------------------------------------------------
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditAccountPage(),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 5, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        // ignore: avoid_unnecessary_containers
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                            'assets/images/myaccount/edit.svg',
                                            width: 91,
                                            height: 28,
                                          ),
                                        ),
                                        const Text("Edit Account")
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
                        ),

                        Container(
                          height: 10,
                        ),

                        // end-------------------
                        // start------------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/images/myaccount/pepare.svg',
                                          width: 91,
                                          height: 28,
                                        ),
                                      ),
                                      const Text("My Orders")
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
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/images/myaccount/location.svg',
                                          width: 91,
                                          height: 28,
                                        ),
                                      ),
                                      const Text("My Addresses")
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
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/images/myaccount/heart.svg',
                                          width: 91,
                                          height: 28,
                                        ),
                                      ),
                                      const Text("Wish list")
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
                        Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/images/myaccount/lock.svg',
                                          width: 91,
                                          height: 28,
                                        ),
                                      ),
                                      const Text("Change Password")
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
                        // end-------------------
                        Container(
                          margin: const EdgeInsets.only(bottom: 5, top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: avoid_unnecessary_containers
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          'assets/images/myaccount/logout.svg',
                                          width: 91,
                                          height: 28,
                                        ),
                                      ),
                                      const Text("Logout")
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
                    margin: const EdgeInsets.only(top: 50),
                    child: const Text(
                      "Settings",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 92, 90, 90)),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 92, 90, 90)),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                                        margin:
                                            const EdgeInsets.only(right: 10),
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
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.center,
                    child: const Text("V.1.0"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text("© 2023 Best Price. All rights reserved"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: const Text("Powered By Line"),
                  )
                ]),
              ),
            ),
          );
  }
}

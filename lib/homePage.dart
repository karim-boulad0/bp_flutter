import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterproject/components/banners_side.dart';
import 'package:flutterproject/components/brands_side.dart';
import 'package:flutterproject/components/categories/categories.dart';
import 'package:flutterproject/components/categories_side.dart';
import 'package:flutterproject/components/myaccount/myAccount.dart';
import 'package:flutterproject/components/myaccount/myAccountVisitor.dart';
import 'package:flutterproject/components/products_side.dart';
import 'package:flutterproject/services/authService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
// variables----------------------------------------------
  List banners = [];
  List categories = [];
  List brands = [];
  List newstProducts = [];
  List featuredProducts = [];
  List bestSellerProducts = [];
  bool isLoading = true;
  int _selectedIndex = 0; // Added to track selected index
  @override
  void initState() {
    super.initState();
    fetchHomePageData();
    _handleAuth();
  }

  Future<void> fetchHomePageData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.5:8000/api/getHomePage'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          banners = data['item']['banners'];
          categories = data['item']['categories'];
          newstProducts = data['item']['newstProducts'];
          brands = data['item']['brands'];
          featuredProducts = data['item']['featuredProducts'];
          bestSellerProducts = data['item']['bestSellerProducts'];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

// ---------------------
// ---------------------
  bool isAuthenticated = false;
  Map<String, dynamic>? user;
  String? token;
  AuthService authService = AuthService();

  _handleAuth() async {
    token = await authService.returnToken();
    bool authResult =
        await authService.checkAuth(token); // Wait for checkAuth to complete
    setState(() {
      authService.setIsAuth(authService);
      isAuthenticated =
          authResult; // Update isAuthenticated based on the awaited result
    });
  }

// ---------------------
// ---------------------
//end  variables------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Ensure labels are always shown
          currentIndex: _selectedIndex,
          onTap: (value) {
            setState(() {
              _selectedIndex = value;
            });
          },
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.black,

          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.category_outlined), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shop_2_outlined), label: "Cart"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: "Account"),
          ],
        ),
        appBar: AppBar(
          title: _selectedIndex == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      'assets/images/home/bestPriceHome.svg',
                      width: 91,
                      height: 28,
                    ),
                    SvgPicture.asset(
                      'assets/icons/search.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                )
              : _selectedIndex == 3
                  ? const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'My Account',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
        ),
        body: InkWell(
          onTap: () {
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
            setState(() {
              _handleAuth();
            });
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
          },
          child: IndexedStack(
            index: _selectedIndex,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: ListView(
                  children: [
                    const Text(
                      "Let's Start Shopping!",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Container(
                      height: 20,
                    ),
                    SizedBox(
                      height: 170,
                      child: Padding(
                        padding: const EdgeInsets.all(
                            0), // Optional padding around the PageView
                        child: BannersSide(banners: banners),
                      ),
                    ),
                    Container(
                      height: 10,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Catgeoires",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedIndex = 1;
                            });
                          },
                          child: const Text(
                            "See All",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 20,
                    ),
                    Expanded(
                        child: CategoriesSide(
                      categories: categories,
                    )),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Featured products",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ProductsSide(
                      products: featuredProducts,
                    )),
                    Container(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Best Selling",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Expanded(
                        child: ProductsSide(
                      products: bestSellerProducts,
                    )),
                    Container(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Brands",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Expanded(
                        child: BrandsSide(
                      brands: brands,
                    )),
                    Container(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "newstProducts",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Container(
                      height: 10,
                    ),
                    Expanded(
                        child: ProductsSide(
                      products: newstProducts,
                    )),
                    Container(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.all(20),
                  child: SizedBox(
                    child: Categories(categories: categories),
                  )),
              Container(
                child: Text("data"),
              ),
              Container(
                child: isAuthenticated ? MyAccount() : MyAccountVisitor(),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoryById extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const CategoryById({Key? key, required this.categoryId, required this.categoryName}) : super(key: key);

  @override
  _CategoryByIdState createState() => _CategoryByIdState();
}

class _CategoryByIdState extends State<CategoryById> {
  List products = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHomePageData();
  }

  Future<void> fetchHomePageData() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.1.5:8000/api/getCategoryById/${widget.categoryId}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          products = (data['items'][0]['products'] as List?) ?? [];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color.fromARGB(255, 92, 90, 90))
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: const Color.fromARGB(255, 22, 21, 21),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? const Center(child: Text('No products found.'))
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5,  // Adjust this value to control the card's height
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, i) {
                    return Container(
                      height: 400,  // Set the height of each card
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                width: double.infinity,
                                height: 200,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(products[i]['image']),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 15,
                                      right: 5,
                                      child: SvgPicture.asset(
                                        'assets/images/home/heart.svg',
                                        width: 91,
                                        height: 28,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${products[i]['price'] - (products[i]['price'] * (products[i]['discount_price'] / 100))} KD",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${products[i]['price']} KD",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 103, 102, 102),
                                      decoration: TextDecoration.lineThrough,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " (${products[i]['discount_price']}%)",
                                    style: const TextStyle(
                                      fontSize: 10,
                                      color: Color.fromARGB(255, 103, 102, 102),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "${products[i]['name']}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 103, 102, 102),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${products[i]['brand_name'] ?? 'Unknown'}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${products[i]['company_name']}",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

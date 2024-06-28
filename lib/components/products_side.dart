import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductsSide extends StatelessWidget {
  final List products;

  const ProductsSide({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, i) {
          return Container(
            width: 185, // Set the width of each card to 150
            margin: const EdgeInsets.only(right: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                          width:
                              150, 
                          height: 200,
                          child: Stack(
                            children: [
                              Container(
                                width: 150,
                                height: 200,
                                padding: const EdgeInsets.all(0.75),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .transparent, // Adjust color as needed
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(products[i]['image']!),
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 13,
                              ),
                              Text(
                                "${products[i]['price'] - (products[i]['price'] * (products[i]['discount_price'] / 100))} KD",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 148, 11, 11),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Text(
                                      "${products[i]['price']} KD",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 103, 102, 102),
                                        decoration: TextDecoration.lineThrough,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "(${products[i]['discount_price']} %)",
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color:
                                            Color.fromARGB(255, 103, 102, 102),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
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
                                "${products[i]['brand_name']}",
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

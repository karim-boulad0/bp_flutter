import 'package:flutter/material.dart';

class BrandsSide extends StatelessWidget {
  final List brands;

  const BrandsSide({Key? key, required this.brands}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: brands.length,
          itemBuilder: (context, i) {
            return Container(
              margin: const EdgeInsets.only(
                right: 9,
              ),
              child: Column(
                children: [
                  // ignore: avoid_unnecessary_containers
                  Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 235, 230, 230),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Center(
                              child: Container(
                                width: 93,
                                height: 24,
                                padding: const EdgeInsets.all(0.75),
                                decoration: BoxDecoration(
                                  color: Colors
                                      .transparent, // Adjust color as needed
                                  image: DecorationImage(
                                    fit: BoxFit.contain,
                                    image: NetworkImage(brands[i]['image']),
                                  ),
                                ),
                              ),
                            ),
                 
                          ],
                        ),
                      )),
                ],
              ),
            );
          }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutterproject/components/categories/CategoryById.dart'; 

class CategoriesSide extends StatelessWidget {
  final List categories;

  const CategoriesSide({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryById(
                      categoryId: categories[i]['id'],
                      categoryName: categories[i]['name'],
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(right: 9),
                child: Column(
                  children: [
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
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              width: 24,
                              height: 24,
                              padding: const EdgeInsets.all(0.75),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(categories[i]['image']),
                                ),
                              ),
                            ),
                            Text(
                              "${categories[i]['name']}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 103, 102, 102),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}

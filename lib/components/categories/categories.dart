import 'package:flutter/material.dart';
import 'package:flutterproject/components/categories/CategoryById.dart';

class Categories extends StatelessWidget {
  final List categories;

  const Categories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 173,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1,
            ),
            itemCount: categories.length,
            itemBuilder: (context, i) {
              return GestureDetector(
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
                  width: 173,
                  height: 173,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 235, 230, 230),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                            image: NetworkImage(categories[i]['image']),
                          ),
                        ),
                      ),
                      Text(
                        categories[i]['name'],
                        style: const TextStyle(
                          color: Color.fromARGB(255, 103, 102, 102),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

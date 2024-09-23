import 'package:flutter/material.dart';
import 'package:project_name/pages/product_page.dart';

class Item extends StatelessWidget {
  final String imgLink;
  final int price;
  final String brand;
  final String title;
  final String description;

  const Item({
    super.key,
    required this.imgLink,
    required this.price,
    required this.brand,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.network(imgLink),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$price ₽',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 26,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              brand,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPage(
                      imgLink: imgLink,
                      price: price,
                      brand: brand,
                      title: title,
                      description: description,
                    ),
                  ),
                );
              },
              child: const Text(
                'Узнать больше',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

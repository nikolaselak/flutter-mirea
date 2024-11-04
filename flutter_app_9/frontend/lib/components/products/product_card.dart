import 'package:flutter/material.dart';
import 'package:frontend/pages/product_page.dart';

class ProductCard extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String brand;
  final String title;
  final int price;
  final String description;

  const ProductCard({
    required this.id,
    required this.imageUrl,
    required this.brand,
    required this.title,
    required this.price,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(imageUrl, height: 150, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$price руб.',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(id: id),
                      ),
                    );
                  },
                  child: const Text(
                    'Узнать больше',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Логика для добавления в корзину
                },
                child: const Text('Добавить в корзину'),
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: const Icon(Icons.favorite_border, color: Colors.grey),
              onPressed: () {
                // Логика для избранного
              },
            ),
          ),
        ],
      ),
    );
  }
}

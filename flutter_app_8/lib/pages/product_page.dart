import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  final String imgLink;
  final double price;
  final String brand;
  final String title;
  final String description;
  final VoidCallback onAddToBasket;

  const ProductPage({
    super.key,
    required this.imgLink,
    required this.price,
    required this.brand,
    required this.title,
    required this.description,
    required this.onAddToBasket,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imgLink),
              const SizedBox(height: 20),
              Text(
                '$price ₽',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                brand,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: onAddToBasket,
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Добавить в корзину'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

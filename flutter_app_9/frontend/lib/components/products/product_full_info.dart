import 'package:flutter/material.dart';
import 'package:frontend/models/product.dart';

class ProductFullInfo extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  const ProductFullInfo(
      {required this.product, required this.onDelete, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:
                Image.network(product.imageUrl, height: 200, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(
            product.brand,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Цена: ${product.price} руб.',
            style: const TextStyle(fontSize: 16, color: Colors.green),
          ),
          const SizedBox(height: 8),
          const Text(
            'Описание:',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(product.description, style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Добавить в корзину
              },
              child: const Text('Добавить в корзину'),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: onDelete,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Удалить',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}

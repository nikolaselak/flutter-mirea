import 'package:flutter/material.dart';
import 'package:flutter_app_7/types/product.dart';
import 'package:flutter_app_7/components/product_item.dart';

class MainPage extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddToCart;

  MainPage({required this.products, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Каталог услуг'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
              product: products[index], onAddToCart: onAddToCart);
        },
      ),
    );
  }
}

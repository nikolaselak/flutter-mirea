import 'package:flutter/material.dart';
import 'package:frontend/components/products/product_full_info.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product_api_service.dart';
import 'edit_product_page.dart';

class ProductPage extends StatefulWidget {
  final int id;

  const ProductPage({required this.id, Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductApiService _productApiService = ProductApiService();
  late Future<Product> _product;

  @override
  void initState() {
    super.initState();
    _product = _productApiService.fetchProductById(widget.id);
  }

  // удаление продукта
  Future<void> _deleteProduct() async {
    try {
      await _productApiService.deleteProduct(widget.id);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
        (Route<dynamic> route) => false,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка при удалении продукта: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Информация о продукте'),
      ),
      body: FutureBuilder<Product>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ProductFullInfo(
              product: snapshot.data!,
              onDelete: _deleteProduct,
            );
          } else {
            return const Center(child: Text('Продукт не найден'));
          }
        },
      ),
      floatingActionButton: FutureBuilder<Product>(
        future: _product,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditProductPage(product: snapshot.data!),
                  ),
                );
              },
              child: const Icon(Icons.edit),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

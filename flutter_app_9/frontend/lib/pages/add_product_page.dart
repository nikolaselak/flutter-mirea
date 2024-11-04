import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product_api_service.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final ProductApiService _productApiService = ProductApiService();

  Future<void> _submitProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        final newProduct = Product(
          id: 0,
          imageUrl: _imageUrlController.text,
          price: int.parse(_priceController.text),
          brand: _brandController.text,
          title: _titleController.text,
          description: _descriptionController.text,
        );

        await _productApiService.addProduct(newProduct);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при добавлении продукта: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Добавить продукт')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _imageUrlController,
                decoration:
                    const InputDecoration(labelText: 'Ссылка на изображение'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Введите ссылку на изображение'
                      : null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  return value == null || value.isEmpty ? 'Введите цену' : null;
                },
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Бренд'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Введите бренд'
                      : null;
                },
              ),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Название'),
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Введите название'
                      : null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 3,
                validator: (value) {
                  return value == null || value.isEmpty
                      ? 'Введите описание'
                      : null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitProduct,
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

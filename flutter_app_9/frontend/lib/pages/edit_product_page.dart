import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/models/product.dart';
import 'package:frontend/services/product_api_service.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({required this.product, Key? key}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _imageUrlController;
  late TextEditingController _priceController;
  late TextEditingController _brandController;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();

    _imageUrlController = TextEditingController(text: widget.product.imageUrl);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
    _brandController = TextEditingController(text: widget.product.brand);
    _titleController = TextEditingController(text: widget.product.title);
    _descriptionController =
        TextEditingController(text: widget.product.description);
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _priceController.dispose();
    _brandController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submitEditProduct() async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedProduct = Product(
          id: widget.product.id,
          imageUrl: _imageUrlController.text,
          price: int.parse(_priceController.text),
          brand: _brandController.text,
          title: _titleController.text,
          description: _descriptionController.text,
        );

        final productApiService = ProductApiService();
        await productApiService.updateProduct(updatedProduct);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при обновлении продукта: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактировать продукт')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL изображения'),
                validator: (value) =>
                    value!.isEmpty ? 'Введите URL изображения' : null,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Введите цену' : null,
              ),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(labelText: 'Бренд'),
                validator: (value) => value!.isEmpty ? 'Введите бренд' : null,
              ),
              TextFormField(
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: 'Название продукта'),
                validator: (value) =>
                    value!.isEmpty ? 'Введите название продукта' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Описание'),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Введите описание' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitEditProduct,
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

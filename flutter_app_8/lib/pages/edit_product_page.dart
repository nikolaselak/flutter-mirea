import 'package:flutter/material.dart';
import 'package:project_name/models/item_class.dart';

class EditProductPage extends StatefulWidget {
  final ItemClass item;
  final Function(ItemClass) onItemUpdated;

  const EditProductPage({
    Key? key,
    required this.item,
    required this.onItemUpdated,
  }) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final TextEditingController imgLinkController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Инициализация контроллеров данными товара
    imgLinkController.text = widget.item.imageUrl;
    priceController.text = widget.item.price.toString();
    brandController.text = widget.item.brand;
    titleController.text = widget.item.title;
    descriptionController.text = widget.item.description;
  }

  @override
  void dispose() {
    imgLinkController.dispose();
    priceController.dispose();
    brandController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _updateItem() {
    final updatedItem = ItemClass(
      widget.item.id,
      imgLinkController.text,
      double.parse(priceController.text),
      brandController.text,
      titleController.text,
      descriptionController.text,
    );

    widget.onItemUpdated(updatedItem);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Редактировать товар'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: imgLinkController,
              decoration:
                  const InputDecoration(labelText: 'Ссылка на изображение'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Цена'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Бренд'),
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Название'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Описание'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateItem,
              child: const Text('Сохранить изменения'),
            ),
          ],
        ),
      ),
    );
  }
}

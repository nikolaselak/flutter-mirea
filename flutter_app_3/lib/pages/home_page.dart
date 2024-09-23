import 'package:flutter/material.dart';
import 'package:project_name/components/item.dart';
import 'package:project_name/data/items.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список товаров'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];
          return Item(
            imgLink: item.imgLink,
            price: item.price,
            brand: item.brand,
            title: item.title,
            description: item.description,
          );
        },
      ),
    );
  }
}

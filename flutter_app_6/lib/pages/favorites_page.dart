import 'package:flutter/material.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/components/item.dart';

class FavoritesPage extends StatelessWidget {
  final List<ItemClass> favorites;
  final Function(ItemClass) onFavoriteToggle; // Добавляем параметр

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.onFavoriteToggle, // Получаем функцию
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text(
                'Нет избранных товаров',
                style: TextStyle(fontSize: 18),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.43,
                crossAxisSpacing: 2,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                final item = favorites[index];
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Item(
                    imgLink: item.imgLink,
                    price: item.price,
                    brand: item.brand,
                    title: item.title,
                    description: item.description,
                    isFavorite: true,
                    onFavoriteToggle: () {
                      onFavoriteToggle(item);
                    },
                    onAddToBasket: () {},
                  ),
                );
              },
            ),
    );
  }
}

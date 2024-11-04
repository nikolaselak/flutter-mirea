import 'package:flutter/material.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/components/item.dart';
import 'package:project_name/models/cart_item_class.dart';

class FavoritesPage extends StatelessWidget {
  final List<ItemClass> favorites;
  final List<CartItemClass> basketItems;
  final Function(ItemClass) onFavoriteToggle;
  final Function(ItemClass) onAddToBasket;
  final Function(ItemClass) onIncreaseQuantity;
  final Function(ItemClass) onDecreaseQuantity;

  const FavoritesPage({
    super.key,
    required this.favorites,
    required this.basketItems,
    required this.onFavoriteToggle,
    required this.onAddToBasket,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
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
                final quantity = basketItems
                    .firstWhere(
                      (cartItem) => cartItem.product == item,
                      orElse: () => CartItemClass(product: item, quantity: 0),
                    )
                    .quantity;

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Item(
                    imgLink: item.imageUrl,
                    price: item.price,
                    brand: item.brand,
                    title: item.title,
                    description: item.description,
                    isFavorite: true,
                    onFavoriteToggle: () {
                      onFavoriteToggle(item);
                    },
                    onAddToBasket: () => onAddToBasket(item),
                    quantity: quantity,
                    onIncreaseQuantity: () => onIncreaseQuantity(item),
                    onDecreaseQuantity: () => onDecreaseQuantity(item),
                  ),
                );
              },
            ),
    );
  }
}

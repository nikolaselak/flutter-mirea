import 'package:flutter/material.dart';
import 'package:project_name/components/item.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/models/cart_item_class.dart';
import 'package:project_name/api/api_service.dart';

class HomePage extends StatefulWidget {
  final List<ItemClass> favorites;
  final List<CartItemClass> basketItems;
  final Function(ItemClass) onFavoriteToggle;
  final Function(ItemClass) onAddToBasket;
  final Function(ItemClass) onIncreaseQuantity;
  final Function(ItemClass) onDecreaseQuantity;

  const HomePage({
    super.key,
    required this.favorites,
    required this.basketItems,
    required this.onFavoriteToggle,
    required this.onAddToBasket,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  late Future<List<ItemClass>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = _apiService.getItems();
  }

  int _getItemQuantity(ItemClass item) {
    final cartItem = widget.basketItems.firstWhere(
      (cartItem) => cartItem.product == item,
      orElse: () => CartItemClass(product: item, quantity: 0),
    );
    return cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Магазин товаров'),
      ),
      body: FutureBuilder<List<ItemClass>>(
        future: _itemsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Ошибка загрузки товаров: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Товары отсутствуют.'));
          } else {
            final items = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.44,
                crossAxisSpacing: 2,
                mainAxisSpacing: 10,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                final item = items[index];
                final quantity = _getItemQuantity(item);

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Item(
                    imgLink: item.imageUrl,
                    price: item.price,
                    brand: item.brand,
                    title: item.title,
                    description: item.description,
                    isFavorite: widget.favorites.contains(item),
                    onFavoriteToggle: () => widget.onFavoriteToggle(item),
                    onAddToBasket: () => widget.onAddToBasket(item),
                    quantity: quantity,
                    onIncreaseQuantity: () => widget.onIncreaseQuantity(item),
                    onDecreaseQuantity: () => widget.onDecreaseQuantity(item),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

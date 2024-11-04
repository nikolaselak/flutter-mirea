import 'package:flutter/material.dart';
import 'package:project_name/pages/home_page.dart';
import 'package:project_name/pages/add_item_page.dart';
import 'package:project_name/pages/favorites_page.dart';
import 'package:project_name/pages/profile_page.dart';
import 'package:project_name/pages/basket_page.dart';
import 'package:project_name/components/navbar.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/models/cart_item_class.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ItemClass> favorites = [];
  List<CartItemClass> basketItems = [];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addItemToFavorites(ItemClass item) {
    setState(() {
      if (favorites.contains(item)) {
        favorites.remove(item);
      } else {
        favorites.add(item);
      }
    });
  }

  void _addItemToBasket(ItemClass item) {
    setState(() {
      final existingCartItem = basketItems.firstWhere(
        (cartItem) => cartItem.product == item,
        orElse: () => CartItemClass(product: item),
      );

      if (basketItems.contains(existingCartItem)) {
        existingCartItem.quantity++;
      } else {
        basketItems.add(CartItemClass(product: item, quantity: 1));
      }
    });
  }

  void _updateItemQuantityInBasket(ItemClass item, int quantity) {
    setState(() {
      final cartItem = basketItems.firstWhere(
        (cartItem) => cartItem.product == item,
        orElse: () => CartItemClass(product: item),
      );

      if (quantity > 0) {
        cartItem.quantity = quantity;
      } else {
        basketItems.remove(cartItem);
      }
    });
  }

  void _increaseItemQuantity(ItemClass item) {
    setState(() {
      final cartItem = basketItems.firstWhere(
        (cartItem) => cartItem.product == item,
        orElse: () => CartItemClass(product: item),
      );

      cartItem.quantity++;
    });
  }

  void _decreaseItemQuantity(ItemClass item) {
    setState(() {
      final cartItem = basketItems.firstWhere(
        (cartItem) => cartItem.product == item,
        orElse: () => CartItemClass(product: item),
      );

      if (cartItem.quantity > 1) {
        cartItem.quantity--;
      } else {
        basketItems.remove(cartItem);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      HomePage(
        favorites: favorites,
        basketItems: basketItems,
        onFavoriteToggle: _addItemToFavorites,
        onAddToBasket: _addItemToBasket,
        onIncreaseQuantity: _increaseItemQuantity,
        onDecreaseQuantity: _decreaseItemQuantity,
      ),
      FavoritesPage(
        favorites: favorites,
        basketItems: basketItems,
        onFavoriteToggle: _addItemToFavorites,
        onAddToBasket: _addItemToBasket,
        onIncreaseQuantity: _increaseItemQuantity,
        onDecreaseQuantity: _decreaseItemQuantity,
      ),
      BasketPage(
        basketItems: basketItems,
        onQuantityChange: _updateItemQuantityInBasket,
      ),
      const ProfilePage(),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Navbar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        floatingActionButton: _selectedIndex == 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddItemPage(onItemAdded: _addItemToBasket),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )
            : null,
      ),
    );
  }
}

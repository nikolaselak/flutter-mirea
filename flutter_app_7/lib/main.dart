import 'package:flutter/material.dart';
import 'package:flutter_app_7/components/navbar.dart';
import 'package:flutter_app_7/pages/main_page.dart';
import 'package:flutter_app_7/pages/basket_page.dart';
import 'package:flutter_app_7/pages/profile_page.dart';
import 'package:flutter_app_7/types/product.dart';
import 'package:flutter_app_7/types/cart_item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Product> products = [
    Product(
      title: 'ПЦР-тест на определение РНК коронавируса стандартный',
      description: '2 дня',
      price: 1800,
      deliveryTime: '2 дня',
    ),
    Product(
      title: 'Клинический анализ крови с лейкоцитарной формулировкой',
      description: '1 день',
      price: 690,
      deliveryTime: '1 день',
    ),
    Product(
      title: 'Биохимический анализ крови, базовый',
      description: '1 день',
      price: 2440,
      deliveryTime: '1 день',
    ),
  ];

  List<CartItem> cartItems = [];

  void addToCart(Product product) {
    setState(() {
      CartItem? existingItem = cartItems.firstWhere(
        (item) => item.product == product,
        orElse: () => CartItem(product: product, quantity: 0),
      );

      if (existingItem.quantity > 0) {
        existingItem.quantity++;
      } else {
        cartItems.add(CartItem(product: product, quantity: 1));
      }
    });
  }

  void increaseQuantity(CartItem item) {
    setState(() {
      item.quantity++;
    });
  }

  void decreaseQuantity(CartItem item) {
    setState(() {
      if (item.quantity > 1) {
        item.quantity--;
      } else {
        cartItems.remove(item);
      }
    });
  }

  void removeFromCart(CartItem item) {
    setState(() {
      cartItems.remove(item);
    });
  }

  void checkout() {
    print('Оформление заказа');
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      MainPage(
        products: products,
        onAddToCart: addToCart,
      ),
      BasketPage(
        cartItems: cartItems,
        onCheckout: checkout,
        removeFromCart: removeFromCart,
        onIncreaseQuantity: increaseQuantity,
        onDecreaseQuantity: decreaseQuantity,
      ),
      ProfilePage(),
    ];

    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Navigation Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'Montserrat'),
          bodyMedium: TextStyle(fontFamily: 'Montserrat'),
          bodySmall: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      home: Scaffold(
        body: _pages.elementAt(_selectedIndex),
        bottomNavigationBar: NavBar(
          selectedIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

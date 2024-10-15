import 'package:flutter/material.dart';
import 'package:flutter_app_7/components/cart_product_item.dart';
import 'package:flutter_app_7/types/cart_item.dart';

class BasketPage extends StatelessWidget {
  final List<CartItem> cartItems;
  final VoidCallback onCheckout;
  final Function(CartItem) removeFromCart;
  final Function(CartItem) onIncreaseQuantity;
  final Function(CartItem) onDecreaseQuantity;

  BasketPage({
    required this.cartItems,
    required this.onCheckout,
    required this.removeFromCart,
    required this.onIncreaseQuantity,
    required this.onDecreaseQuantity,
  });

  @override
  Widget build(BuildContext context) {
    double totalPrice = cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return CartProductItem(
                  cartItem: cartItems[index],
                  onRemove: () => removeFromCart(cartItems[index]),
                  onIncreaseQuantity: () =>
                      onIncreaseQuantity(cartItems[index]),
                  onDecreaseQuantity: () =>
                      onDecreaseQuantity(cartItems[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Сумма',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '$totalPrice ₽',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onCheckout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(26, 111, 238, 1),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Перейти к оформлению заказа',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:project_name/models/cart_item_class.dart';
import 'package:project_name/components/basket_item.dart';
import 'package:project_name/models/item_class.dart';

class BasketPage extends StatefulWidget {
  final List<CartItemClass> basketItems;
  final Function(ItemClass, int) onQuantityChange;

  const BasketPage({
    super.key,
    required this.basketItems,
    required this.onQuantityChange,
  });

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var cartItem in widget.basketItems) {
      totalPrice += cartItem.product.price * cartItem.quantity;
    }
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: widget.basketItems.isEmpty
          ? const Center(
              child: Text(
                'Корзина пуста',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.basketItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cartItem = widget.basketItems[index];
                      return Dismissible(
                        key: Key(cartItem.product.title),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            widget.onQuantityChange(cartItem.product, 0);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  '${cartItem.product.title} удален из корзины'),
                            ),
                          );
                        },
                        child: BasketItem(
                          cartItem: cartItem,
                          onIncrease: () {
                            widget.onQuantityChange(
                                cartItem.product, cartItem.quantity + 1);
                          },
                          onDecrease: () {
                            widget.onQuantityChange(
                                cartItem.product, cartItem.quantity - 1);
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Общая сумма: ${totalPrice.toStringAsFixed(2)} ₽',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      label: const Text('Купить'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

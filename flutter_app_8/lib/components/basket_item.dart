import 'package:flutter/material.dart';
import 'package:project_name/models/cart_item_class.dart';

class BasketItem extends StatelessWidget {
  final CartItemClass cartItem;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const BasketItem({
    Key? key,
    required this.cartItem,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Image.network(cartItem.product.imageUrl),
        title: Text(cartItem.product.title),
        subtitle: Text('${cartItem.product.price} руб.'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onDecrease,
            ),
            Text('${cartItem.quantity}'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onIncrease,
            ),
          ],
        ),
      ),
    );
  }
}

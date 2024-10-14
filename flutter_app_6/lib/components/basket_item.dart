import 'package:flutter/material.dart';
import 'package:project_name/models/item_class.dart';

class BasketItem extends StatelessWidget {
  final ItemClass item;
  final int quantity;
  final VoidCallback onRemove;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const BasketItem({
    Key? key,
    required this.item,
    required this.quantity,
    required this.onRemove,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        leading: Image.network(item.imgLink),
        title: Text(item.title),
        subtitle: Text('${item.price} руб.'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onDecrease,
            ),
            Text('$quantity'),
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

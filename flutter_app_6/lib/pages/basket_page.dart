import 'package:flutter/material.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/components/basket_item.dart';

class BasketPage extends StatefulWidget {
  final List<ItemClass> basketItems;
  final Function(ItemClass) onRemove;

  const BasketPage({
    super.key,
    required this.basketItems,
    required this.onRemove,
  });

  @override
  _BasketPageState createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  late Map<ItemClass, int> itemCountMap;

  @override
  void initState() {
    super.initState();
    _updateItemCountMap();
  }

  void _updateItemCountMap() {
    itemCountMap = {};
    for (var item in widget.basketItems) {
      if (itemCountMap.containsKey(item)) {
        itemCountMap[item] = itemCountMap[item]! + 1;
      } else {
        itemCountMap[item] = 1;
      }
    }
  }

  void _increaseQuantity(ItemClass item) {
    setState(() {
      itemCountMap[item] = itemCountMap[item]! + 1;
    });
  }

  void _decreaseQuantity(ItemClass item) {
    setState(() {
      if (itemCountMap[item]! > 1) {
        itemCountMap[item] = itemCountMap[item]! - 1;
      } else {
        widget.onRemove(item);
      }
    });
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;
    itemCountMap.forEach((item, quantity) {
      totalPrice += item.price * quantity; // Умножаем цену на количество
    });
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = _calculateTotalPrice(); // Рассчитываем общую сумму

    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: itemCountMap.isEmpty
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
                    itemCount: itemCountMap.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = itemCountMap.keys.elementAt(index);
                      final quantity = itemCountMap[item]!;

                      return Dismissible(
                        key: Key(item.title),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            widget.onRemove(item);
                            itemCountMap.remove(item);
                          });

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${item.title} удален из корзины'),
                            ),
                          );
                        },
                        child: BasketItem(
                          item: item,
                          quantity: quantity,
                          onRemove: () {
                            widget.onRemove(item);
                          },
                          onIncrease: () {
                            _increaseQuantity(item);
                          },
                          onDecrease: () {
                            _decreaseQuantity(item);
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

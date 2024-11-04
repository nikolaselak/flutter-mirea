import 'package:project_name/models/item_class.dart';

class CartItemClass {
  final ItemClass product;
  int quantity;

  CartItemClass({required this.product, this.quantity = 1});
}

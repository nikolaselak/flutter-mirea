import 'package:flutter/material.dart';
import 'package:project_name/pages/product_page.dart';

class Item extends StatelessWidget {
  final String imgLink;
  final int price;
  final String brand;
  final String title;
  final String description;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAddToBasket;

  const Item({
    Key? key,
    required this.imgLink,
    required this.price,
    required this.brand,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAddToBasket,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Image.network(imgLink, height: 150, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      title,
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '$price руб.',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductPage(
                          imgLink: imgLink,
                          price: price,
                          brand: brand,
                          title: title,
                          description: description,
                          onAddToBasket: onAddToBasket, // Передаем функцию
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    'Узнать больше',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: onAddToBasket,
                color: Colors.blue,
              ),
            ],
          ),
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: onFavoriteToggle,
            ),
          ),
        ],
      ),
    );
  }
}

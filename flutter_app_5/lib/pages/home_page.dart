import 'package:flutter/material.dart';
import 'package:project_name/components/item.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/pages/add_item_page.dart';
import 'package:project_name/pages/favorites_page.dart';
import 'package:project_name/pages/profile_page.dart';
import 'package:project_name/components/navbar.dart';
import 'package:project_name/data/items_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemClass> favorites = [];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = [
      Scaffold(
        appBar: AppBar(
          title: const Text('Магазин товаров'),
        ),
        body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.43,
            crossAxisSpacing: 2,
            mainAxisSpacing: 10,
          ),
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Item(
                imgLink: item.imgLink,
                price: item.price,
                brand: item.brand,
                title: item.title,
                description: item.description,
                isFavorite: favorites.contains(item),
                onFavoriteToggle: () {
                  setState(() {
                    if (favorites.contains(item)) {
                      favorites.remove(item);
                    } else {
                      favorites.add(item);
                    }
                  });
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddItemPage(onItemAdded: (newItem) {
                  setState(() {
                    items.add(newItem);
                  });
                }),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
      Scaffold(
        body: FavoritesPage(favorites: favorites),
      ),
      const Scaffold(
        body: ProfilePage(),
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Navbar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

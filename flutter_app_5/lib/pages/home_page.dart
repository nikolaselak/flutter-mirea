import 'package:flutter/material.dart';
import 'package:project_name/components/item.dart';
import 'package:project_name/models/item_class.dart';
import 'package:project_name/pages/add_item_page.dart';
import 'package:project_name/pages/favorites_page.dart';
import 'package:project_name/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ItemClass> items = [
    ItemClass(
      1,
      'https://static.re-store.ru/upload/resize_cache/iblock/d14/100500_800_140cd750bba9870f18aada2478b24840a/v3psvqegwnvsxxzjqd0b3ynbe9895cd2.jpg',
      115990,
      'Apple',
      'Apple iPhone 16 dual-SIM 128 ГБ, ультрамарин',
      'Смартфон от Apple с 128 ГБ памяти',
    ),
    ItemClass(
      2,
      'https://static.re-store.ru/upload/resize_cache/iblock/683/100500_800_140cd750bba9870f18aada2478b24840a/mdrt1dye5g9s8oosylyd9jzxfv68grjb.jpg',
      135990,
      'Apple',
      'Apple iPhone 16 Pro 256 ГБ, космический серый',
      'Флагманский смартфон Apple с 256 ГБ памяти',
    ),
    ItemClass(
      3,
      'https://static.re-store.ru/upload/resize_cache/iblock/687/100500_800_140cd750bba9870f18aada2478b24840a/bar79xbho0dww32wzrbj79246qnm8eqv.jpg',
      47990,
      'Apple',
      'Apple Watch Series 9, серебристый алюминий',
      'Умные часы Apple с GPS и 45мм экраном',
    ),
    ItemClass(
      4,
      'https://static.re-store.ru/upload/resize_cache/iblock/ac7/100500_800_140cd750bba9870f18aada2478b24840a/ac7fa7156fc033f1b5fa47e541716d7e.jpeg',
      249990,
      'Apple',
      'Apple MacBook Pro 14" M2, 16 ГБ, 512 ГБ SSD',
      'Ноутбук Apple с процессором M2 и Retina дисплеем',
    ),
    ItemClass(
      5,
      'https://static.re-store.ru/upload/resize_cache/iblock/d76/100500_800_140cd750bba9870f18aada2478b24840a/d7687c4047344a6ebd92a158b08ea272.jpg',
      89990,
      'Apple',
      'Apple iPad Pro 11", Wi-Fi, 128 ГБ, серый',
      'Планшет Apple с процессором M1 и поддержкой Apple Pencil',
    ),
    ItemClass(
      6,
      'https://img.mvideo.ru/Big/30067950bb2.jpg',
      114990,
      'Samsung',
      'Samsung Galaxy Z Flip5, 256 ГБ, кремовый',
      'Смартфон Samsung с гибким экраном и 256 ГБ памяти',
    ),
    ItemClass(
      7,
      'https://c.dns-shop.ru/thumb/st1/fit/wm/0/0/01ce578db862c3f0e0f1f6e0d42f68c2/f85b56cc2544cd50ed9135fc975507050fae7af62124438363941fea09f41826.jpg.webp',
      139990,
      'Samsung',
      'Samsung Galaxy S23 Ultra, 512 ГБ, зеленый',
      'Флагманский смартфон Samsung с 512 ГБ памяти и камерой 200 МП',
    ),
    ItemClass(
      8,
      'https://tochkasvyazi.ru/images/thumbnails/550/450/detailed/146/e3y26yw7jo7i9zr_59d6846c.jpg.webp.webp',
      40990,
      'Samsung',
      'Samsung Galaxy Watch 5 Pro, титановый',
      'Умные часы Samsung с GPS и большим AMOLED экраном',
    ),
    ItemClass(
      9,
      'https://static.re-store.ru/upload/resize_cache/iblock/687/100500_800_140cd750bba9870f18aada2478b24840a/bar79xbho0dww32wzrbj79246qnm8eqv.jpg',
      47990,
      'Apple',
      'Apple Watch Series 9, серебристый алюминий',
      'Умные часы Apple с GPS и 45мм экраном',
    ),
    ItemClass(
      10,
      'https://static.re-store.ru/upload/resize_cache/iblock/ac7/100500_800_140cd750bba9870f18aada2478b24840a/ac7fa7156fc033f1b5fa47e541716d7e.jpeg',
      249990,
      'Apple',
      'Apple MacBook Pro 14" M2, 16 ГБ, 512 ГБ SSD',
      'Ноутбук Apple с процессором M2 и Retina дисплеем',
    ),
  ];

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
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Item(
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
        appBar: AppBar(
          title: const Text('Избранное'),
        ),
        body: FavoritesPage(favorites: favorites),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Мой профиль'),
        ),
        body: const ProfilePage(),
      ),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

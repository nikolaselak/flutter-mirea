import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/121338834?v=4',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Селакович Никола',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'selakovich.n@edu.mirea.ru',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

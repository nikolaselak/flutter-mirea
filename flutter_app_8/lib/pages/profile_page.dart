import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController imgLinkController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    imgLinkController.text =
        'https://avatars.githubusercontent.com/u/121338834?v=4';
    nameController.text = 'Селакович Никола';
    emailController.text = 'selakovich.n@edu.mirea.ru';
  }

  @override
  void dispose() {
    imgLinkController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мой профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(imgLinkController.text),
              ),
              const SizedBox(height: 20),
              if (isEditing) ...[
                TextField(
                  controller: imgLinkController,
                  decoration:
                      const InputDecoration(labelText: 'Ссылка на изображение'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Имя'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(labelText: 'Электронная почта'),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleEdit,
                  child: const Text('Сохранить изменения'),
                ),
              ] else ...[
                Text(
                  nameController.text,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  emailController.text,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _toggleEdit,
                  child: const Text('Редактировать'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

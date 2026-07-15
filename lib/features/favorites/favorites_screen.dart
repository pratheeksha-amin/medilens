import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = [
      "Paracetamol",
      "Vitamin C",
      "Cetirizine",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              title: Text(favorites[index]),
            ),
          );
        },
      ),
    );
  }
}
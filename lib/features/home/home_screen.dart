import 'package:flutter/material.dart';
import 'package:medilens/features/scan/scan_screen.dart';
import 'package:medilens/features/history/history_screen.dart';
import 'package:medilens/features/favorites/favorites_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget buildMenuCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color color = Colors.blue,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        child: SizedBox(
          height: 130,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MediLens"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 10),

            const Text(
              "Scan. Understand. Stay Informed.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ScanScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text(
                  "Scan Medicine",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  buildMenuCard(
                    icon: Icons.history,
                    title: "History",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const HistoryScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    icon: Icons.favorite,
                    title: "Favorites",
                    color: Colors.red,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    icon: Icons.search,
                    title: "Search",
                    color: Colors.green,
                    onTap: () {},
                  ),
                  buildMenuCard(
                    icon: Icons.settings,
                    title: "Settings",
                    color: Colors.orange,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
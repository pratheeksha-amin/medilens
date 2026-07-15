import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final medicines = [
      "Paracetamol",
      "Dolo 650",
      "Cetirizine",
      "Amoxicillin",
      "Crocin",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan History"),
      ),
      body: ListView.builder(
        itemCount: medicines.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.medication),
            ),
            title: Text(medicines[index]),
            subtitle: const Text("Scanned Today"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          );
        },
      ),
    );
  }
}
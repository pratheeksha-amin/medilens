import 'package:flutter/material.dart';

class MedicineScreen extends StatelessWidget {
  const MedicineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.medication,
                size: 100,
                color: Colors.blue,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Paracetamol 650 mg",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            buildSection(
              "Uses",
              "Used to reduce fever and relieve mild to moderate pain.",
            ),

            buildSection(
              "General Dosage",
              "Usually taken 1 tablet every 4–6 hours. Do not exceed the recommended daily dose.",
            ),

            buildSection(
              "Common Side Effects",
              "Nausea, stomach upset, allergic reaction (rare).",
            ),

            buildSection(
              "Warnings",
              "Avoid overdose. Consult a doctor if symptoms persist.",
            ),

            buildSection(
              "Storage",
              "Store in a cool, dry place away from direct sunlight.",
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
                label: const Text("Add to Favorites"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                content,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
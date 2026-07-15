import 'package:flutter/material.dart';

class MedicineResultScreen extends StatelessWidget {

  final String medicineName;

  const MedicineResultScreen({
    super.key,
    required this.medicineName,
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Medicine Details"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              medicineName,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),


            infoCard(
              "Used For",
              "Information will appear here",
            ),


            infoCard(
              "Dosage",
              "General dosage information",
            ),


            infoCard(
              "Side Effects",
              "Common side effects",
            ),


            infoCard(
              "Warnings",
              "Precautions",
            ),


            infoCard(
              "Storage",
              "Storage instructions",
            ),

          ],
        ),
      ),
    );
  }



  Widget infoCard(String title, String value){

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(value),

          ],
        ),
      ),
    );

  }
}
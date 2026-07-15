import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/ocr_service.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  final ImagePicker picker = ImagePicker();

  File? selectedImage;

  String extractedText = "";

  Future<void> pickImage() async {

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {
        selectedImage = File(image.path);
      });

      extractMedicineText();
    }
  }


  Future<void> extractMedicineText() async {

    if (selectedImage == null) return;

    String text = await OCRService.extractText(
      selectedImage!,
    );

    setState(() {
      extractedText = text;
    });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text("Scan Medicine"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            Expanded(

              child: selectedImage == null

                  ? const Center(
                child: Text(
                  "Select medicine image",
                ),
              )

                  : Image.file(
                selectedImage!,
              ),
            ),


            ElevatedButton(

              onPressed: pickImage,

              child: const Text(
                "Select Image",
              ),
            ),


            const SizedBox(height:20),


            Expanded(

              child: SingleChildScrollView(

                child: Text(
                  extractedText.isEmpty
                      ? "Extracted text will appear here"
                      : extractedText,
                ),

              ),
            )

          ],

        ),

      ),

    );

  }
}
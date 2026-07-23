import 'dart:io';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/ocr_service.dart';
import '../../services/medicine_parser.dart';
import '../../services/medicine_search_service.dart';
import '../medicine/medicine_result_screen.dart';
import '../../services/medicine_storage_service.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker picker = ImagePicker();

  File? selectedImage;
  String extractedText = "";
  bool isLoading = false;

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      if (!mounted) return; // ✅ guard before setState
      setState(() {
        selectedImage = File(image.path);
      });

      extractMedicineText();
    }
  }

  Future<void> extractMedicineText() async {
    if (selectedImage == null) return;

    try {
      if (!mounted) return; // ✅ guard before setState
      setState(() {
        isLoading = true;
      });

      String text = await OCRService.extractText(selectedImage!);

      if (!mounted) return; // ✅ guard before setState
      setState(() {
        extractedText = text;
      });

      String medicineName = MedicineParser.extractMedicineName(text);
      debugPrint("Medicine detected: $medicineName");

      final result = await MedicineSearchService()
          .searchMedicine(medicineName, context.locale.languageCode);

      if (result != null) {
        await MedicineStorageService.addToHistory({
          "name": medicineName,
          "data": result,
        });
      }

      if (!mounted) return; // ✅ guard before setState
      setState(() {
        isLoading = false;
      });

      if (!mounted) return; // ✅ guard before Navigator
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => MedicineResultScreen(
            medicineName: medicineName,
            data: result,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return; // ✅ guard before setState
      setState(() {
        isLoading = false;
      });

      debugPrint("Medicine scan error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('scan.title'.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: selectedImage == null
                  ? Center(
                child: Text('scan.selectPrompt'.tr()),
              )
                  : Image.file(selectedImage!),
            ),
            ElevatedButton(
              onPressed: isLoading ? null : pickImage,
              child: isLoading
                  ? const CircularProgressIndicator()
                  : Text('scan.selectButton'.tr()),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  extractedText.isEmpty
                      ? 'scan.extractedPlaceholder'.tr()
                      : extractedText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

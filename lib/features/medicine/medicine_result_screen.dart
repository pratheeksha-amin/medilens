import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../services/medicine_storage_service.dart';
import '../../services/medicine_search_service.dart';

class MedicineResultScreen extends StatefulWidget {
  final String medicineName;
  final Map<String, dynamic>? data;

  const MedicineResultScreen({
    super.key,
    required this.medicineName,
    this.data,
  });

  @override
  State<MedicineResultScreen> createState() => _MedicineResultScreenState();
}

class _MedicineResultScreenState extends State<MedicineResultScreen> {
  Map<String, dynamic>? translatedData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTranslatedData();
  }

  Future<void> _fetchTranslatedData() async {
    try {
      final langCode = context.locale.languageCode;

      final data = await MedicineSearchService()
          .searchMedicine(widget.medicineName, langCode);

      setState(() {
        translatedData = data ?? widget.data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        translatedData = widget.data;
        isLoading = false;
      });
    }
  }

  String getField(String key, String fallback) {
    final value = translatedData?[key] ?? widget.data?[key];

    if (value == null) return fallback;

    if (value is String) {
      return value;
    }

    if (value is List) {
      if (value.isEmpty) return fallback;

      return value.map((item) {
        if (item is String) {
          return item;
        }

        if (item is Map<String, dynamic>) {
          if (item.containsKey("text")) {
            return item["text"].toString();
          }

          return item.values.join(", ");
        }

        return item.toString();
      }).join("\n");
    }

    if (value is Map<String, dynamic>) {
      if (value.containsKey("text")) {
        return value["text"].toString();
      }

      return value.values.join("\n");
    }

    return value.toString();
  }

  Future<void> addToFavourite() async {
    await MedicineStorageService.addFavourite({
      "name": widget.medicineName,
      "data": translatedData ?? widget.data,
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("medicineResult.added_to_favorites".tr()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final medicine = translatedData ?? widget.data;

    return Scaffold(
      appBar: AppBar(
        title: Text('medicineResult.title'.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: addToFavourite,
          ),
        ],
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : medicine == null
          ? Center(
        child: Text(
          'medicineResult.notFound'.tr(),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.medicineName,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              infoCard(
                'medicineResult.usedFor'.tr(),
                getField(
                  'indications_and_usage',
                  'medicineResult.infoPlaceholder'.tr(),
                ),
              ),

              infoCard(
                'medicineResult.dosage'.tr(),
                getField(
                  'dosage_and_administration',
                  'medicineResult.generalDosageInfo'.tr(),
                ),
              ),

              infoCard(
                'medicineResult.sideEffects'.tr(),
                getField(
                  'adverse_reactions',
                  'medicineResult.commonSideEffects'.tr(),
                ),
              ),

              infoCard(
                'medicineResult.warnings'.tr(),
                getField(
                  'warnings',
                  'medicineResult.precautions'.tr(),
                ),
              ),

              infoCard(
                'medicineResult.storage'.tr(),
                getField(
                  'storage_and_handling',
                  'medicineResult.storageInstructions'.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget infoCard(String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
            const SizedBox(height: 8),
            Text(value),
          ],
        ),
      ),
    );
  }
}

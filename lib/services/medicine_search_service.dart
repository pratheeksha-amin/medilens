import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class TranslationService {
  /// Translates a given text into the target language using the MyMemory API.
  Future<String> translateText(String text, String targetLang) async {
    try {
      if (text.trim().isEmpty) return text;

      // Ensure the language pair is correctly formatted (e.g., "en|hi")
      final url = Uri.parse(
        "https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=en|$targetLang",
      );

      final response = await http.get(url).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        debugPrint("Translation failed with status: ${response.statusCode}");
        return text;
      }

      final json = jsonDecode(response.body);

      if (json is Map<String, dynamic>) {
        final responseData = json["responseData"];

        if (responseData is Map<String, dynamic>) {
          final translated = responseData["translatedText"];

          if (translated is String && translated.isNotEmpty) {
            // MyMemory sometimes returns HTML entities like &quot;. This cleans them.
            return translated.replaceAll("&quot;", '"').replaceAll("&#39;", "'");
          }
        }
      }

      return text;
    } catch (e) {
      debugPrint("Translation Error: $e");
      return text;
    }
  }
}

class MedicineSearchService {
  static const String _baseUrl = "https://api.fda.gov/drug/label.json";

  /// Searches for medicine data and translates key informational fields.
  /// Preserves the original API data structure (Lists) to prevent Model errors.
  Future<Map<String, dynamic>?> searchMedicine(
      String medicineName,
      String targetLang,
      ) async {
    try {
      // Encode medicine name to handle spaces or special characters in the URL
      final query = Uri.encodeComponent(medicineName);
      final uri = Uri.parse("$_baseUrl?search=openfda.brand_name:\"$query\"&limit=1");

      final response = await http.get(uri).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        debugPrint("FDA API Error: ${response.statusCode} - ${response.body}");
        return null;
      }

      final json = jsonDecode(response.body);

      if (json["results"] == null || (json["results"] as List).isEmpty) {
        debugPrint("No results found for $medicineName");
        return null;
      }

      // Create a copy of the first result
      final result = Map<String, dynamic>.from(json["results"][0]);

      final translator = TranslationService();

      final fieldsToTranslate = [
        "indications_and_usage",
        "dosage_and_administration",
        "adverse_reactions",
        "warnings",
        "storage_and_handling",
      ];

      for (String field in fieldsToTranslate) {
        final value = result[field];

        if (value is List && value.isNotEmpty) {
          // IMPORTANT: We translate the items but keep them inside a List
          // to maintain compatibility with the data models.
          final List<String> translatedList = [];

          for (var item in value) {
            if (item is String) {
              final translated = await translator.translateText(item, targetLang);
              translatedList.add(translated);
            }
          }
          result[field] = translatedList; // Assigned back as a List

        } else if (value is String) {
          result[field] = await translator.translateText(value, targetLang);
        }
      }

      return result;
    } catch (e) {
      debugPrint("Medicine Search Error: $e");
      return null;
    }
  }
}

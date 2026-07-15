import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  static const String languageKey = "selected_language";

  static Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, code);
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(languageKey) ?? "en"; // default English
  }
}

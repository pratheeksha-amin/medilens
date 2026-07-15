import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final languages = [
      {"name": "English", "code": "en"},
      {"name": "ಕನ್ನಡ", "code": "kn"},
      {"name": "हिन्दी", "code": "hi"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('chooseLanguage'.tr()), // ✅ localized
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          return ListTile(
            title: Text(lang["name"]!),
            onTap: () {
              // ✅ change locale dynamically
              context.setLocale(Locale(lang["code"]!));
            },
          );
        },
      ),
    );
  }
}

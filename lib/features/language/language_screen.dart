import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../models/language.dart';

/// Lets the user pick the app's display language.
///
/// Reachable from Settings > Language. Tapping a language immediately
/// switches the whole app's text (via easy_localization's `setLocale`)
/// without restarting the app, and the choice is persisted automatically
/// by easy_localization (SharedPreferences under the hood), so it is
/// remembered the next time the app is opened.
class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentCode = context.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text('language.chooseLanguage'.tr()),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: (context, index) {
          final lang = languages[index];
          final isSelected = lang.code == currentCode;

          return ListTile(
            title: Text(lang.name),
            trailing: isSelected
                ? const Icon(Icons.check_circle, color: Colors.blue)
                : null,
            onTap: () async {
              await context.setLocale(Locale(lang.code));

              // If this screen was pushed from Settings, go back to it
              // now that the language has changed. If it's the very
              // first screen shown (no back stack), stay here so the
              // user can see the confirmation checkmark update.
              if (context.mounted && Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
          );
        },
      ),
    );
  }
}

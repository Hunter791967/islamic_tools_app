import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/main_islamic_app.dart';

void main() async {
  // Use Easy Localization Package in Localization and Sets the initial locale
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      // Uses locale from EasyLocalization.
      supportedLocales: const [Locale('ar'), Locale('en')],
      // Loads the correct JSON file
      path: 'assets/translations',
      fallbackLocale:
          const Locale('ar'), //fallback if device locale not supported
      startLocale: const Locale('ar'), // this sets Arabic as the default
      child: const MainIslamicApp()));
}

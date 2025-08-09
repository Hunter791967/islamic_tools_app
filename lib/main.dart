import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'main_islamic_app.dart';

late BuildContext easyLocalizationRootContext;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('ar'),
      startLocale: const Locale('ar'),
      child: Builder(
        builder: (context) {
          easyLocalizationRootContext = context;
          return const MainIslamicApp();
        },
      ),
    ),
  );
}


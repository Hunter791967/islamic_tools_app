import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/themes/app_theme.dart';
import 'package:islamic_tools_app/views/hadeeth_tab_details.dart';
import 'package:islamic_tools_app/views/quran_tab_details.dart';
import 'package:islamic_tools_app/views/splash_view.dart';


class MainIslamicApp extends StatefulWidget {
  const MainIslamicApp({super.key});

  @override
  State<MainIslamicApp> createState() => _MainIslamicAppState();
}

class _MainIslamicAppState extends State<MainIslamicApp> {
  bool _isDarkMode = false;

  void _toggleTheme(bool isDark) {
    setState(() {
      _isDarkMode = isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Islamic_APP',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      routes: {
        'quranDetails': (context) => const QuranTabDetails(),
        'hadeethDetails': (context) => const HadeethTabDetails(),
      },
      home: SplashView(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

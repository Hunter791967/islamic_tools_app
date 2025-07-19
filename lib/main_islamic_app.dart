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
      // Use the Current active locale
      locale: context.locale,
      // List of all supported languages
      supportedLocales: context.supportedLocales,
      // Built-in + easy_localization delegates for text rendering
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      title: 'Islamic_APP',
      theme: AppTheme.lightTheme, // 🌞 Light Theme
      darkTheme: AppTheme.darkTheme, // 🌙 Dark Theme
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light, // Can be .light or .dark or .system

      // ✅ Pass theme toggle callback to child routes if needed
      routes: {
        // 'splash': (context) => SplashView(
        //   isDarkMode: _isDarkMode,
        //   onThemeChanged: _toggleTheme,
        // ),
        'quranDetails': (context) => const QuranTabDetails(),
        'hadeethDetails': (context) => const HadeethTabDetails(),
      },
      //initialRoute: 'splash',
      // 👇 Replace routes + initialRoute with home:
      home: SplashView(
        isDarkMode: _isDarkMode,
        onThemeChanged: _toggleTheme,
      ),
    );
  }
}

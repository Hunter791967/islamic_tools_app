
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/views/home_view.dart';

class SplashView extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const SplashView({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 3),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => HomeView(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/islamiat.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).colorScheme.secondary.withAlpha(166)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }
}



// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:islamic_tools_app/views/home_view.dart';
//
// class SplashView extends StatefulWidget {
//   const SplashView({super.key});
//
//   @override
//   State<SplashView> createState() => _SplashViewState();
// }
//
// class _SplashViewState extends State<SplashView> {
//
//
//   @override
//   void initState() {
//     super.initState();
//     //Use Timer to set time for replacing the splash screen with home screen
//     Timer(
//       const Duration(seconds: 3),
//       () => Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const HomeView())),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Image.asset(
//             'assets/images/islamiat.png',
//             fit: BoxFit.cover,
//             height: double.infinity,
//             width: double.infinity,
//           ),
//           // 🔥 Add overlay based on current theme mode
//           Container(
//             color: Theme.of(context).brightness == Brightness.dark
//                 ? Theme.of(context).colorScheme.secondary.withOpacity(0.65) // Dark Mode
//                 : Colors.transparent, // Light mode transparent
//           ),
//         ]
//       ),
//     );
//   }
// }

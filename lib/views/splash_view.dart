import 'dart:async';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/views/home_view.dart';

enum SplashAnimationType { overlap, fade }

class SplashView extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;
  final SplashAnimationType animationType;

  const SplashView({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.animationType = SplashAnimationType.overlap,
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Schedule navigation after 2s
    _timer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;

      // Use a PageRouteBuilder that renders BOTH splash and home during transition
      Navigator.of(context).pushReplacement(PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1200),
        pageBuilder: (context, animation, secondaryAnimation) {
          return HomeView(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          );
        },
        transitionsBuilder: (context2, animation, secondaryAnimation, child) {
          // splash transforms (shrink + rotate + fade out)
          final splashScale = Tween<double>(begin: 1.0, end: 0.6)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
          final splashRotate = Tween<double>(begin: 0.0, end: 0.25)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut));
          final splashOpacity = Tween<double>(begin: 1.0, end: 0.0)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOut));

          // home transforms (fade in + slight zoom)
          final homeOpacity = animation;
          final homeScale = Tween<double>(begin: 0.95, end: 1.0)
              .animate(CurvedAnimation(parent: animation, curve: Curves.easeOutBack));

          return Stack(
            children: [
              // Splash: shrinks/rotates/fades out
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (ctx, _) {
                    return Opacity(
                      opacity: splashOpacity.value,
                      child: Transform.rotate(
                        angle: splashRotate.value,
                        child: Transform.scale(
                          scale: splashScale.value,
                          child: _buildSplashContent(ctx),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Home: fades & scales in on top
              Positioned.fill(
                child: FadeTransition(
                  opacity: homeOpacity,
                  child: ScaleTransition(
                    scale: homeScale,
                    child: child,
                  ),
                ),
              ),
            ],
          );
        },
      ));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildSplashContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background image (use your original file)
        Image.asset(
          'assets/images/islamiat.png', // <- your image path
          fit: BoxFit.cover,
        ),

        // Optional color overlay for dark mode (keeps same look as before)
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.secondary.withValues(alpha: 0.6)
              : Colors.transparent,
        ),

        // (Optional) logo or centered widget — remove or replace if you want image-only
        // Center(child: Image.asset('assets/images/your_logo.png', width: 160)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildSplashContent(context),
    );
  }
}




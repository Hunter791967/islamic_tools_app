import 'dart:async';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/views/home_view.dart';

enum SplashAnimationType { fade, scale, slide, rotate }

class SplashView extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  /// 🔥 Choose animation type here
  final SplashAnimationType animationType;

  const SplashView({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
    this.animationType = SplashAnimationType.fade, // default is fade
  });

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // ✅ Define different animations
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -1), // moves up
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _rotateAnimation = Tween<double>(begin: 0.0, end: 2 * 3.1416).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // ⏳ Show splash for 2 seconds, then animate
    Timer(const Duration(seconds: 2), () {
      _controller.forward();
    });

    // 🎯 Navigate to Home when animation finishes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => HomeView(
              isDarkMode: widget.isDarkMode,
              onThemeChanged: widget.onThemeChanged,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// ✅ Common splash content
  Widget _buildSplashContent() {
    return Stack(
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
    );
  }

  /// ✅ Choose animation wrapper based on selected type
  Widget _buildAnimatedSplash() {
    switch (widget.animationType) {
      case SplashAnimationType.scale:
        return ScaleTransition(
            scale: _scaleAnimation, child: _buildSplashContent());
      case SplashAnimationType.slide:
        return SlideTransition(
            position: _slideAnimation, child: _buildSplashContent());
      case SplashAnimationType.rotate:
        return RotationTransition(
          turns: _rotateAnimation,
          child: FadeTransition(
              opacity: _fadeAnimation, child: _buildSplashContent()),
        );
      case SplashAnimationType.fade:
        return FadeTransition(
            opacity: _fadeAnimation, child: _buildSplashContent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildAnimatedSplash());
  }
}


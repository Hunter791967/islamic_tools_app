
import 'package:flutter/material.dart';

TextStyle langStyle(BuildContext context) {
  return TextStyle(
    fontFamily: 'kofi',
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: Theme.of(context).colorScheme.onPrimary,
    shadows: [
      Shadow(
        blurRadius: 4,
        color: Colors.black.withOpacity(0.6),
        offset: const Offset(2, 2),
      ),
    ],
  );
}

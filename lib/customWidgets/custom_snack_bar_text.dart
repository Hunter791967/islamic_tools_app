
import 'package:flutter/material.dart';

class CustomSnackBarText {
  final String snackBarText; // Text to display in SnackBar
  final Color snackBarColor; // Foreground text color
  final Color backgroundColor; // Background color of the SnackBar
  final double fontSize; // Font size for the text
  final FontWeight fontWeight; // Font weight for the text

  // Constructor to initialize all properties
  CustomSnackBarText({
    required this.snackBarText,
    this.snackBarColor = Colors.white, // Default text color is white
    this.backgroundColor = Colors.black, // Default background color is black
    this.fontSize = 14.0, // Default font size is 14.0
    this.fontWeight = FontWeight.normal, // Default font weight is normal
  });

  // Method to display the custom SnackBar
  void showCustomSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        snackBarText,
        style: TextStyle(
          color: snackBarColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
      backgroundColor: backgroundColor,
      duration: const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


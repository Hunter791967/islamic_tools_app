
import 'package:flutter/material.dart';
//import '../utils/components/app_colors.dart';


class CustomButton extends StatelessWidget {
  CustomButton({super.key,
    required this.buttonText,
    this.onTap,
    required this.bgColor,
    required this.fgColor,
    this.fontSize,
    this.fontWeight});

  String buttonText;
  VoidCallback? onTap;
  final Color bgColor;
  final Color fgColor;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(16)
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              color: fgColor,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key,
      required this.textTitle,
      required this.textColor,
      required this.fontSize,
      this.fontWeight,
      this.fontFamily,
      this.shadowColor,
      this.blurRadius,
      this.offsetOne,
      this.offsetTwo,
      this.textDirection,
      this.textOverflow,
      this.textAlign});

  final String textTitle;
  final Color textColor;
  final double fontSize;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? shadowColor;
  final double? blurRadius;
  final double? offsetOne;
  final double? offsetTwo;
  final TextDirection? textDirection;
  final bool? softWrap = true;
  final TextOverflow? textOverflow;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textTitle,
      softWrap: softWrap,
      overflow: textOverflow, // or ellipsis, if you want to limit
      textDirection: textDirection,
      textAlign: textAlign,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        shadows: [
          Shadow(
            blurRadius: blurRadius ?? 1.0,
            color: shadowColor ?? Colors.grey.withOpacity(0.5),
            offset: Offset(offsetOne ?? 2.0, offsetTwo ?? 2.0),
          ),
        ],
      ),
    );
  }
}

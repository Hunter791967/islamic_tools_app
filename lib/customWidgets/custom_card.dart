import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.childWidget,
      required this.cardColor,
      this.boxShadowColor,
      this.blurRadius,
      this.spreadRadius,
      this.offsetOne,
      this.offSetTwo,
      this.cardElevation,
      this.containerWidth,
      this.containerHeight,
      this.horizontalMargin,
      this.vertMargin});

  final Widget childWidget;
  final Color cardColor;
  final Color? boxShadowColor;
  final double? blurRadius;
  final double? spreadRadius;
  final double? offsetOne, offSetTwo;
  final double? cardElevation;
  final double? containerWidth, containerHeight;
  final double? horizontalMargin, vertMargin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: boxShadowColor != null
            ? [
                BoxShadow(
                  blurRadius: blurRadius ?? 4.0,
                  color: boxShadowColor!,
                  spreadRadius: spreadRadius ?? 1.0,
                  offset: Offset(offsetOne ?? 2.0, offSetTwo ?? 2.0),
                )
              ]
            : null,
      ),
      width: containerWidth,
      height: containerHeight,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: horizontalMargin ?? 8, vertical: vertMargin ?? 8),
        elevation: cardElevation,
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0, left: 10.0, right: 10.0, bottom: 10.0),
          child: childWidget,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {super.key,
      required this.title,
      required this.subTitle,
      this.trailing,
      required this.textColorOne,
      required this.textColorTwo,
      required this.dFontSizeOne,
      required this.dFontSizeTwo,
      required this.dFontWeightOne,
      required this.dFontWeightTwo,
      this.dFontFamily,
      this.lSpacing,
      required this.topPadding});

  final String title;
  final String subTitle;
  final Widget? trailing;
  final Color textColorOne;
  final Color textColorTwo;
  final int dFontSizeOne;
  final int dFontSizeTwo;
  final FontWeight dFontWeightOne;
  final FontWeight dFontWeightTwo;
  final String? dFontFamily;
  final double? lSpacing;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          fontFamily: dFontFamily,
          fontSize: dFontSizeOne.toDouble(),
          fontWeight: dFontWeightOne,
          color: textColorOne,
          letterSpacing: lSpacing,
        ),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(top: topPadding),
        child: Text(
          subTitle,
          style: TextStyle(
            fontFamily: dFontFamily,
            fontSize: dFontSizeTwo.toDouble(),
            fontWeight: dFontWeightTwo,
            color: textColorTwo,
            letterSpacing: lSpacing,
          ),
        ),
      ),
      trailing: trailing,
    );
  }
}

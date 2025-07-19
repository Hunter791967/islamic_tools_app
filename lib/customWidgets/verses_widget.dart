import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/customWidgets/custom_text.dart';
import 'package:islamic_tools_app/utils/arabic_number_converter.dart';

class VersesWidget extends StatelessWidget {
  const VersesWidget(
      {super.key, required this.versesContent, required this.index});

  final String versesContent;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context); // auto detect from locale
    // 👈 current app locale
    final bool isArabic = context.locale.languageCode == 'ar';

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, top: 8, bottom: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CustomText(
                textTitle: versesContent,
                textDirection: textDirection,
                textColor: Theme.of(context).colorScheme.onPrimary,
                fontSize: 24,
                blurRadius: 4,
                offsetOne: 2,
                offsetTwo: 2,
                shadowColor: Colors.black.withAlpha(153),
                fontFamily: 'kofi',
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(width: 4,),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                isArabic ? convertToArabicNumber(index + 1) : '${index + 1}',
                style: TextStyle(
                  fontFamily: 'kofi',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onError,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    //Text('$versesContent ${index+1}'); //add 1 to make the index starts at 1
  }
}

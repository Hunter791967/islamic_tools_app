import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/customWidgets/custom_text.dart';
import 'package:islamic_tools_app/customWidgets/custom_title.dart';
import 'package:islamic_tools_app/models/quran_list_names.dart';

class QuranTab extends StatelessWidget {
  const QuranTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CustomText(
          textTitle: 'quran_tab.al_surah'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 42,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withAlpha(153),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
        ),


      Expanded(
        child: ListView.separated(
            padding:
                const EdgeInsets.symmetric(vertical: 4, horizontal: 64), // Reduce extra spacing
            shrinkWrap: true, // ✅ Important to avoid over-expanding
            physics:
                const BouncingScrollPhysics(), // Optional: smoother scrolling
            //Use arrow function in building items
            itemBuilder: (context, index) =>
                CustomTitle(quranChapter: quranChapters[index]),
            //Use normal function in building separators
            separatorBuilder: (context, index) {
              return Container(
                color: Theme.of(context).dividerColor,
                height: 1.5,
                width: double.infinity,
                //margin: const EdgeInsets.symmetric(horizontal: 64),
              );
            },
            itemCount: quranChapters.length),
      ),
    ]);
  }
}

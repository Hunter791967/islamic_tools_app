import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/models/hadeeth_list_model.dart';
import '../models/quran_list_model.dart';
import '../utils/arabic_number_converter.dart';

class HadeethTitle extends StatelessWidget {
  const HadeethTitle({super.key, this.quranChapter, this.hadeethChapter});

  final QuranListModel? quranChapter; // Declare the QuranListModel
  final HadeethListModel? hadeethChapter; // Declare the HadeethListModel


  @override
  Widget build(BuildContext context) {
    // Construct display title based on content type
    String displayTitle =
    quranChapter != null ? quranChapter!.quranListName : 'الحديث رقم ';
    // 👈 current app locale
    final bool isArabic = context.locale.languageCode == 'ar';

    //Using Material Widget to Wrap Ink & InkWell with Material to make it give the
    //the visual effect.
    return Material(
      color: Colors.transparent, // Keep background transparent
      child: Ink(
        height: MediaQuery.of(context).size.height * .10,
        //Using InkWell instead of GestureDetection to give also, visual effect like
        //Ripple Animation provided by InkWell.
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.secondary,
          highlightColor:
          Theme.of(context).colorScheme.secondary.withAlpha(51),
          //radius: 300,
          onTap: () {
            // Use Timer for more control over the delay
            Future.delayed(const Duration(milliseconds: 150), () {
              if (context.mounted) {
                if (quranChapter != null) {
                  Navigator.pushNamed(context, 'quranDetails',
                      arguments: quranChapter);
                } else if (hadeethChapter != null) {
                  Navigator.pushNamed(context, 'hadeethDetails',
                      arguments: hadeethChapter);
                }
              }
            });
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Title text (fixed width container)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45, // Or fixed e.g. 220
                  child: Text(
                    displayTitle,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'kofi',
                      fontSize: isArabic ? 42 : 36,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.onPrimary,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black.withAlpha(153),
                          offset: const Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ),

                // CircleAvatar (aligned properly)
                Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Text(
                      convertToArabicNumber(quranChapter?.quranListNumber ??
                          hadeethChapter?.hadeethListNumber ?? 0),
                      style: TextStyle(
                        fontFamily: 'kofi',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onError,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }
}

import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/customWidgets/custom_container.dart';
import '../customWidgets/custom_text.dart';

class TasbeehTab extends StatefulWidget {
  const TasbeehTab({super.key});

  @override
  State<TasbeehTab> createState() => _TasbeehTabState();
}

class _TasbeehTabState extends State<TasbeehTab> {
  //This is to define the rotating angel
  double rotationAngle = 0;
  // ≈ 33°, this is to define each required step degree
  final double step = 360 / 10.9090;
  int tasbeeh = 0; // current tasbeeh counter from 0–33
  int totalCount = 0; // total clicks
  List<String> tasbeehName = [
    'tasabeeh_tab.subhan'.tr(),
    'tasabeeh_tab.alhamd'.tr(),
    'tasabeeh_tab.akbar'.tr()
  ];
  String currentTasbeehDisplayed = 'tasabeeh_tab.subhan'.tr();

  void rotateImage() {
    setState(() {
      rotationAngle += step * pi / 180; // convert degrees to radians
      //increase the counter 1 by 1
      totalCount++;
      //increase tasbeeh till 33 and reset each time for 34 to be 0
      tasbeeh = totalCount % 34;
      /* Step-by-step breakdown:
         totalCount ~/ 33 - This is integer division (floor division) in Dart
         The ~/ operator divides and returns only the whole number part
         For example: if totalCount = 100, then 100 ~/ 34 = 2 (not 2.94...)
         This calculates how many complete cycles of 33 counts have been completed
         % tasbeehName.length - This is the modulo operator
         It returns the remainder after division
         This ensures the result stays within the bounds of the tasbeehName array
         For example: if tasbeehName.length = 5 and the previous result was 7,
         then 7 % 5 = 2
         The combined effect: Every 33 counts, the tasbeeh name changes to the next
         one in the list When you reach the end of the name list, it cycles back
         to the beginning.
         Practical example:
         Let's say tasbeehName = ["سبحان الله", "الحمد لله", "الله أكبر"]
         (length = 3)
         totalCount = 0-33: nameIndex = 0 → "سبحان الله"
         totalCount = 34-66: nameIndex = 1 → "الحمد لله"
         totalCount = 67-99: nameIndex = 2 → "الله أكبر"
         totalCount = 100-132: nameIndex = 0 → "سبحان الله" (cycles back)
         Purpose: This code appears to be for a digital tasbeeh (prayer counter)
         app that automatically switches between different Islamic phrases every
          33 recitations, which is a common practice in Islamic prayer counting.*/
      int nameIndex = (totalCount ~/ 34) % tasbeehName.length;
      //Update the displayed name based on how many full 33-count cycles have passed.
      currentTasbeehDisplayed = tasbeehName[nameIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          textTitle: 'tasabeeh_tab.al_tasbeehat'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 36,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withAlpha(153),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
        ),
        Transform.rotate(
          angle: rotationAngle,
          child: Stack(alignment: Alignment.topCenter, children: [
            // Glowing circle behind the tasbeeh
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.error.withAlpha(204),
                    blurRadius: 20,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: rotateImage,
              child: ClipOval(
                child: Image.asset(
                  'assets/images/sebha05.png',
                  width: MediaQuery.of(context).size.width * 0.60,
                  height: MediaQuery.of(context).size.height * 0.26,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ]),
        ),
        CustomText(
          textTitle: 'tasabeeh_tab.tasbeehat_no'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 24,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withAlpha(153),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
        ),
        const SizedBox(
          height: 20,
        ),
        CustomContainer(
          width: 70,
          height: 90,
          boxShadowColor: Theme.of(context).colorScheme.onSurface,
          opacity: 204,
          offsetOne: 2,
          offsetTwo: 2,
          blurRadius: 4,
          spreadRadius: -10,
          borderRadius: 16,
          containerBgColor: Theme.of(context).colorScheme.secondary,
          widget: Center(
            child: Text(
              tasbeeh.toString(),
              style: const TextStyle(
                fontSize: 28,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        CustomContainer(
          width: 226,
          height: 60,
          boxShadowColor: Theme.of(context).colorScheme.onSurface,
          opacity: 204,
          offsetOne: 2,
          offsetTwo: 2,
          blurRadius: 4,
          spreadRadius: -10,
          borderRadius: 16,
          containerBgColor: Theme.of(context).colorScheme.secondary,
          widget: Center(
            child: Text(
              currentTasbeehDisplayed,
              style: const TextStyle(
                //fontFamily: 'kofi',
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        )
      ],
    );
  }
}

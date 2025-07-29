import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../customWidgets/custom_card.dart';
import '../models/hadeeth_list_model.dart';
import '../utils/arabic_number_converter.dart';

class HadeethTabDetails extends StatefulWidget {
  const HadeethTabDetails({super.key});

  @override
  State<HadeethTabDetails> createState() => _HadeethTabDetailsState();
}

class _HadeethTabDetailsState extends State<HadeethTabDetails> {
  // Define a variable carries the tapped hadeeth from the list.
  late HadeethListModel hadeeth;
  // Define this bool to identify if the hadeeth is loaded or not.
  bool _isHadeethLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isHadeethLoaded) {
      hadeeth = ModalRoute.of(context)!.settings.arguments as HadeethListModel;
      _isHadeethLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {

    // 👈 current app locale
    final bool isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      extendBodyBehindAppBar: true, // Key to make body go behind AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onPrimary,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black.withAlpha(153),
              offset: const Offset(2, 2),
            ),
          ], // Arrow color
          size: 32, // Adjust size (default is 24)
        ),
      ),
      body: Stack(children: [
        // Background image
        Image.asset(
          'assets/images/home_page.jpg',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),

        // 🔥 Add overlay based on current theme mode
        Container(
          color: Theme.of(context).brightness == Brightness.dark
              ? Theme.of(context).colorScheme.primary // Dark Mode
              : Colors.transparent, // Light mode transparent
        ),

        Column(
          children: [
            const SizedBox(height: 30), // Top spacing
            // Logo Image
            Center(
              child: Image.asset(
                'assets/images/islamiat01.png',
                width: MediaQuery.of(context).size.width * 0.48,
                height: MediaQuery.of(context).size.height * 0.18,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20), // Optional smaller gap

            Text(
                '${'hadeeth_tab.hadeeth_no'.tr()} ${isArabic
                    ? convertToArabicNumber(hadeeth.hadeethListNumber)
                    : hadeeth.hadeethListNumber}',
              style: TextStyle(
                fontFamily: 'kofi',
                fontSize: 42,
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
            Divider(
              height:
                  20, // The total height of the divider, including the line and its padding
              thickness: 3, // The thickness of the line itself
              indent: 20, // Horizontal space before the line
              endIndent: 20, // Horizontal space after the line
              color:
                  Theme.of(context).colorScheme.onPrimary, // Color of the line
            ),

            Expanded(
              child: CustomCard(
                childWidget: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
                  child: Text(
                    hadeeth.hadeethListContent,
                    style: TextStyle(
                      //fontFamily: 'kofi',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.onPrimary,
                      height: 1.8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                cardColor:
                    Theme.of(context).colorScheme.secondary.withAlpha(77),
                cardElevation: 10,
                blurRadius: 40,
                spreadRadius: 0,
                offsetOne: 5,
                offSetTwo: 5,
                boxShadowColor:
                    Theme.of(context).colorScheme.onPrimary.withAlpha(26),
                horizontalMargin: 24,
                vertMargin: 24,
              ),
            ),
          ],
        )
      ]),
    );
  }
}

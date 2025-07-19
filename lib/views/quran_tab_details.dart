import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_tools_app/customWidgets/custom_card.dart';
import 'package:islamic_tools_app/customWidgets/verses_widget.dart';
import 'package:islamic_tools_app/models/quran_list_model.dart';
import '../utils/text_data_loader.dart';

class QuranTabDetails extends StatefulWidget {
  const QuranTabDetails({super.key});

  @override
  State<QuranTabDetails> createState() => _QuranTabDetailsState();
}

class _QuranTabDetailsState extends State<QuranTabDetails> {
  late QuranListModel quranChapter;
  // Define variable to store the QuranVerses "أيات القرأن"
  List<String> quranVerses = [];

  // Access to context and ModalRoute.of(context).
  // Create function to Load dataFiles from Assets by parsing them.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the passed argument safely here
    quranChapter = ModalRoute.of(context)?.settings.arguments as QuranListModel;

    // Load the data only once
    if (quranVerses.isEmpty) {
      //Reads file using rootBundle.loadString(...)
      loadTextData<String>(
        assetPath: 'assets/dataFiles/${quranChapter.quranListNumber}.txt',

        //Applies the inline parser: split('\n')
        parser: (content) => content.split('\n'),
      ).then((verses) {
        setState(() {
          quranVerses = verses;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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

        // Foreground content
        quranVerses.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                    '${'quran_tab.surah'.tr()} ${quranChapter.quranListName}',
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
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimary, // Color of the line
                  ),

                  Expanded(
                    child: CustomCard(
                      childWidget: ListView.separated(
                          // <== This changes the default padding
                          padding: const EdgeInsets.only(
                              left: 0, right: 0, bottom: 0, top: 16),
                          itemBuilder: (context, index) {
                            return VersesWidget(
                              versesContent: quranVerses[index],
                              index: index,
                            );
                          },
                          //Use normal function in building separators
                          separatorBuilder: (context, index) {
                            return Container(
                              color: Theme.of(context).dividerColor,
                              height: 1.5,
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 64),
                            );
                          },
                          itemCount: quranVerses.length),
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

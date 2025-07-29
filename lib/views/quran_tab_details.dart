import 'dart:async';

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
  List<String> selectedList = [];
  //Using TextEditingController to control the textValue inside textField.
  TextEditingController controller = TextEditingController();
  Timer? _debounce; // 👈 debounce instance

  @override
  void dispose() {
    _debounce?.cancel(); // 👈 cancel debounce on dispose
    controller.dispose();
    super.dispose();
  }

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
          selectedList =
              List.from(verses); // 👈 Ensure selectedList initialized
        });
      });
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      filterSearch(query);
    });
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
        if (quranVerses.isEmpty)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
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
              Padding(
                padding: const EdgeInsets.only(
                    top: 16.0, left: 16, right: 16, bottom: 0),
                child: TextField(
                  controller: controller,
                  onChanged: _onSearchChanged, // 👈 debounce here
                  onSubmitted: (queryResults) {
                    filterSearch(queryResults);
                    //controller.clear(); // Optional: clear text input
                    FocusScope.of(context).unfocus(); // Hide keyboard
                  },

                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 28,
                  ),
                  decoration: InputDecoration(
                      hintText: 'quranTab_details.search'.tr(),
                      hintStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      filled: true,
                      fillColor:
                          Theme.of(context).colorScheme.secondary.withAlpha(77),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(77),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(77),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      prefixIcon: Icon(
                        Icons.search_sharp,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 30,
                      )),
                ),
              ),
              if (selectedList.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'quranTab_details.no_results'
                        .tr(), // 👈 Add to your translations
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                )
              else
                Expanded(
                  child: CustomCard(
                    childWidget: ListView.separated(
                        // <== This changes the default padding
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, bottom: 0, top: 16),
                        itemBuilder: (context, index) {
                          return VersesWidget(
                            versesContent: selectedList[index],
                            index: index,
                          );
                        },
                        //Use normal function in building separators
                        separatorBuilder: (context, index) {
                          return Container(
                            color: Theme.of(context).dividerColor,
                            height: 1.5,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 64),
                          );
                        },
                        itemCount: selectedList.length),
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

  // ✅ Add this helper below filterSearch (but still inside the class)
  String removeDiacritics(String input) {
    const diacritics = [
      '\u064B', // Tanwin Fath
      '\u064C', // Tanwin Damm
      '\u064D', // Tanwin Kasr
      '\u064E', // Fatha
      '\u064F', // Damma
      '\u0650', // Kasra
      '\u0651', // Shadda
      '\u0652', // Sukun
      '\u0670', // Superscript Alef
    ];
    return input.replaceAll(RegExp(diacritics.join('|')), '');
  }

  //This is to convert numbers into arabic before search
  String normalizeDigits(String input) {
    const easternToWestern = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };

    return input.split('').map((char) {
      return easternToWestern[char] ?? char;
    }).join();
  }

  void filterSearch(String queryResults) {
    final cleanedQuery = normalizeDigits(removeDiacritics(queryResults.trim()));

    selectedList = quranVerses
        .asMap()
        .entries
        .where((entry) {
          final index = entry.key;
          final verseText = entry.value;
          final cleanedVerse = removeDiacritics(verseText.trim());

          final verseNumber = (index + 1).toString();

          return cleanedVerse.contains(cleanedQuery) ||
              cleanedVerse.toLowerCase().contains(cleanedQuery.toLowerCase()) ||
              verseNumber.contains(cleanedQuery);
        })
        .map((e) => e.value)
        .toList();

    setState(() {});
  }
}

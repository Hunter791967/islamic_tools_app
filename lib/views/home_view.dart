import 'package:flutter/material.dart';
import 'package:islamic_tools_app/views/hadeth_tab.dart';
import 'package:islamic_tools_app/views/quran_tab.dart';
import 'package:islamic_tools_app/views/radio_tab.dart';
import 'package:islamic_tools_app/views/tasbeeh_tab.dart';

import 'islam_app_setting_tap.dart';

class HomeView extends StatefulWidget {

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  const HomeView({super.key,
    required this.isDarkMode,
    required this.onThemeChanged});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  //define the current index
  int currentIndex = 0;
  //bool isDarkMode = false;
  String selectedLanguage = 'ar';


  @override
  Widget build(BuildContext context) {

    //Define the list of 4-tapped widgets
    List<Widget> islamicTabs = [
      const QuranTab(),
      const HadethTab(),
      const TasbeehTab(),
      const RadioTab(),
      IslamAppSettingTap(
        isDarkMode: widget.isDarkMode,
        onThemeChanged: widget.onThemeChanged,
      ),
    ];

    return Scaffold(
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
            const SizedBox(height: 10), // Optional smaller gap

            // Shrinkable and scrollable content
            Expanded(
              child: islamicTabs[currentIndex],
            ),
          ],
        )
      ]),
      bottomNavigationBar: Directionality(
        textDirection: selectedLanguage == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            // Important for 4+ File Types such as PNG Format
            type: BottomNavigationBarType.fixed,
            backgroundColor: Theme.of(context).colorScheme.secondary,
            selectedItemColor: Theme.of(context).colorScheme.onError,
            unselectedItemColor:
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3 * 255),
            selectedIconTheme: const IconThemeData(
              size: 32,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    'assets/images/ic_quran.png',
                  ),
                ),
                label: 'القرأن الكريم',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/ic_hadeth.png'),
                ),
                label: 'الأربعون النووية',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/ic_sebha.png'),
                ),
                label: 'تسابيح',
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/images/ic_radio.png'),
                ),
                label: 'راديو',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'اعدادات',
              )
            ]),
      ),
    );
  }
}

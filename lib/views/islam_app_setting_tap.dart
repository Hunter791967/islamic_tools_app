
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../customWidgets/custom_text.dart';
import '../utils/styles/arabic_text_style.dart';
import '../utils/components/swipe_only_switch.dart';

class IslamAppSettingTap extends StatefulWidget {
  const IslamAppSettingTap({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  @override
  State<IslamAppSettingTap> createState() => _IslamAppSettingTapState();
}

class _IslamAppSettingTapState extends State<IslamAppSettingTap> {
  late String selectedLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedLanguage = context.locale.languageCode;
  }

  void _changeLanguage(String langCode) {
    setState(() {
      selectedLanguage = langCode;
    });
    context.setLocale(Locale(langCode));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 30),
        CustomText(
          textTitle: 'settings_tab.settings'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: 48,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withValues(alpha: 0.3 * 255),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
        ),
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.brightness_6, size: 36),
                title: Text('settings_tab.theme'.tr(), style: langStyle(context)),
                trailing: SwipeOnlySwitch(
                  value: widget.isDarkMode,
                  onChanged: widget.onThemeChanged,
                ),

              ),
              Divider(
                height: 40,
                thickness: 3,
                indent: 20,
                endIndent: 20,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              ListTile(
                leading: const Icon(Icons.language, size: 36),
                title: Text('settings_tab.language'.tr(), style: langStyle(context)),
                trailing: DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    value: selectedLanguage,
                    customButton: Text(
                      selectedLanguage == 'ar'
                          ? 'settings_tab.arabic'.tr()
                          : 'settings_tab.english'.tr(),
                      style: langStyle(context),
                    ),
                    buttonStyleData: const ButtonStyleData(
                      height: 48,
                      width: 130,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    dropdownStyleData: DropdownStyleData(
                      width: 180,
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      offset: const Offset(-60, -12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'en',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('settings_tab.english'.tr(), style: langStyle(context)),
                            if (selectedLanguage == 'en')
                              Icon(Icons.check, size: 32, color: Theme.of(context).colorScheme.onPrimary),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'ar',
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('settings_tab.arabic'.tr(), style: langStyle(context)),
                            if (selectedLanguage == 'ar')
                              Icon(Icons.check, size: 32, color: Theme.of(context).colorScheme.onPrimary),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) _changeLanguage(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



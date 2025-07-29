
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../customWidgets/custom_text.dart';
import '../customWidgets/custom_title.dart';
import '../models/hadeeth_list_model.dart';
import '../services/hadeeth_services.dart';

/*This widget must be stateful because it needs to get the HadeethModel
data for parsing text data from text file so, it will be in the future.*/

class HadethTab extends StatefulWidget {
  const HadethTab({super.key});

  @override
  State<HadethTab> createState() => _HadethTabState();
}

class _HadethTabState extends State<HadethTab> {

  //Define Hadeeth List
  List<HadeethListModel> hadeethList = [];

  @override
  void initState() {
    super.initState();
    HadithService.loadAllAhadeth().then((data) {
      setState(() {
        hadeethList = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isArabic = context.locale.languageCode == 'ar';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
        children: [
      CustomText(
          textTitle: 'common.ahadeeth'.tr(),
          textColor: Theme.of(context).colorScheme.onPrimary,
          fontSize: isArabic ? 42 : 32,
          fontFamily: 'kofi',
          fontWeight: FontWeight.w900,
          shadowColor: Colors.black.withAlpha(153),
          blurRadius: 4,
          offsetOne: 2,
          offsetTwo: 2,
        ),

      Expanded(
        child: hadeethList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
            padding:
            const EdgeInsets.symmetric(vertical: 4, horizontal: 32), // Reduce extra spacing
            shrinkWrap: true, // ✅ Important to avoid over-expanding
            physics:
            const BouncingScrollPhysics(), // Optional: smoother scrolling
            //Use arrow function in building items
            itemBuilder: (context, index) =>
                CustomTitle(hadeethChapter: hadeethList[index]),
            //Use normal function in building separators
            separatorBuilder: (context, index) {
              return Container(
                color: Theme.of(context).dividerColor,
                height: 1.5,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 64),
              );
            },
            itemCount: hadeethList.length),
      ),
    ]);
  }
}

/*The purpose of this function This function parses a big text file
(ahadeth.txt) that contains all 50 Hadiths in one file. This function
can parsing index, title and the hadeeth content. */

/*Brings in the HadeethListModel which stores each Hadith's data
(index, title, content).*/
import 'package:islamic_tools_app/models/hadeeth_list_model.dart';

//Main function that takes the full file content as a single string.
List<HadeethListModel> parseAhadeth(String content) {

  /*This finds every # symbol followed by optional whitespace —
  which separates each Hadith. */
  final RegExp splitRegex = RegExp(r'#\s*');

  //This captures the title line like الحديث الأول, الحديث الثالث, etc.
  final RegExp titleRegex = RegExp(r'(الحد\s?يث\s.*?)(?=\n)', dotAll: true);

  //Splits the entire file into 50+ chunks (each chunk = 1 Hadith).
  final parts = content.split(splitRegex);

  List<HadeethListModel> hadeethList = [];

  //Iterate through each hadith block.
  for (var part in parts) {
    //Skip if it's an empty string (clean data).
    if (part.trim().isEmpty) continue;
    final titleMatch = titleRegex.firstMatch(part);
    if (titleMatch != null) {
      //The full title, like الحديث الخامس.
      final title = titleMatch.group(1)!.trim();
      //Index is auto-calculated by list size and to prevent starts at 0.
      final index = hadeethList.length + 1;
      //Remove the title from the text so we get pure content.
      final contentOnly = part.replaceFirst(title, '').trim();
      //Store this Hadith in the list.
      hadeethList.add(HadeethListModel(index, title, contentOnly));
    }
  }
  return hadeethList;
}

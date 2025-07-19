
/*
This is to
 */
import '../utils/text_data_loader.dart';

class QuranService {
  static Future<List<String>> loadSurah(int index) async {
    return await loadTextData<String>(
      assetPath: 'assets/dataFiles/$index.txt',

      //convert text into model by using "content"
      parser: (content) => content.split('\n'),
    );
  }
}


import '../models/hadeeth_list_model.dart';
import '../utils/text_data_loader.dart';
import '../services/hadeeth_parser.dart';

class HadithService {
  static Future<List<HadeethListModel>> loadAllAhadeth() async {
    return await loadTextData<HadeethListModel>(
      assetPath: 'assets/dataFiles/ahadeth.txt',
      parser: parseAhadeth,
    );
  }
}


/*This is the first function in the parsing processes. It loads the text
provided the assetPath and the parser function and return the parser with content*/

import 'package:flutter/services.dart';

/* A generic loader that reads text from an asset and parses it
 using the provided function. */
Future<List<T>> loadTextData<T>({
  required String assetPath,
  required List<T> Function(String content) parser,
}) async {
  //Reads file using rootBundle.loadString(...)
  final content = await rootBundle.loadString(assetPath);
  return parser(content);
}
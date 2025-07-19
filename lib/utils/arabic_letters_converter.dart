
class ArabicEnglishConverter {
  // Arabic to English character mapping
  static const Map<String, String> arabicToEnglishMap = {
    'ا': 'a',
    'ب': 'b',
    'ت': 't',
    'ث': 'th',
    'ج': 'j',
    'ح': 'h',
    'خ': 'kh',
    'د': 'd',
    'ذ': 'dh',
    'ر': 'r',
    'ز': 'z',
    'س': 's',
    'ش': 'sh',
    'ص': 's',
    'ض': 'd',
    'ط': 't',
    'ظ': 'z',
    'ع': 'ʿ',
    'غ': 'gh',
    'ف': 'f',
    'ق': 'q',
    'ك': 'k',
    'ل': 'l',
    'م': 'm',
    'ن': 'n',
    'ه': 'h',
    'و': 'w',
    'ي': 'y',
  };

  // Generate English to Arabic mapping by reversing the above map
  static Map<String, String> get englishToArabicMap {
    final Map<String, String> reversedMap = {};

    // Handle multi-character English mappings
    final sortedEntries = arabicToEnglishMap.entries.toList()
      ..sort((a, b) => b.value.length.compareTo(a.value.length));

    for (final entry in sortedEntries) {
      if (!reversedMap.containsKey(entry.value)) {
        reversedMap[entry.value] = entry.key;
      }
    }

    return reversedMap;
  }

  /// Converts Arabic string to English transliteration
  ///
  /// Example:
  /// ```dart
  /// String result = ArabicEnglishConverter.arabicToEnglish('مرحبا');
  /// print(result); // Output: mrhba
  /// ```
  static String arabicToEnglish(String arabicText) {
    if (arabicText.isEmpty) return '';

    StringBuffer result = StringBuffer();

    for (int i = 0; i < arabicText.length; i++) {
      String char = arabicText[i];

      if (arabicToEnglishMap.containsKey(char)) {
        result.write(arabicToEnglishMap[char]);
      } else {
        // Keep non-Arabic characters as they are (spaces, numbers, punctuation)
        result.write(char);
      }
    }

    return result.toString();
  }

  /// Converts English transliteration to Arabic
  ///
  /// Example:
  /// ```dart
  /// String result = ArabicEnglishConverter.englishToArabic('mrhba');
  /// print(result); // Output: مرحبا
  /// ```
  static String englishToArabic(String englishText) {
    if (englishText.isEmpty) return '';

    String result = englishText.toLowerCase();
    final englishToArabic = englishToArabicMap;

    // Sort by length (longest first) to handle multi-character mappings correctly
    final sortedKeys = englishToArabic.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));

    for (String englishChar in sortedKeys) {
      result = result.replaceAll(englishChar, englishToArabic[englishChar]!);
    }

    return result;
  }

  /// Checks if a string contains Arabic characters
  static bool containsArabic(String text) {
    return text.split('').any((char) => arabicToEnglishMap.containsKey(char));
  }

  /// Checks if a string contains English transliteration characters
  static bool containsEnglishTransliteration(String text) {
    final englishToArabic = englishToArabicMap;
    return englishToArabic.keys.any((key) => text.toLowerCase().contains(key));
  }

  /// Auto-detects language and converts accordingly
  /// Returns the converted string along with the detected source language
  static Map<String, String> autoConvert(String text) {
    if (containsArabic(text)) {
      return {
        'converted': arabicToEnglish(text),
        'sourceLanguage': 'Arabic',
        'targetLanguage': 'English'
      };
    } else if (containsEnglishTransliteration(text)) {
      return {
        'converted': englishToArabic(text),
        'sourceLanguage': 'English',
        'targetLanguage': 'Arabic'
      };
    } else {
      return {
        'converted': text,
        'sourceLanguage': 'Unknown',
        'targetLanguage': 'Unknown'
      };
    }
  }
}

// Example usage and testing
void main() {
  // Test Arabic to English conversion
  print('Arabic to English:');
  print('مرحبا -> ${ArabicEnglishConverter.arabicToEnglish('مرحبا')}');
  print('السلام عليكم -> ${ArabicEnglishConverter.arabicToEnglish('السلام عليكم')}');

  // Test English to Arabic conversion
  print('\nEnglish to Arabic:');
  print('mrhba -> ${ArabicEnglishConverter.englishToArabic('mrhba')}');
  print('alslam alykm -> ${ArabicEnglishConverter.englishToArabic('alslam alykm')}');

  // Test auto-conversion
  print('\nAuto-conversion:');
  var result1 = ArabicEnglishConverter.autoConvert('مرحبا');
  print('مرحبا -> ${result1['converted']} (${result1['sourceLanguage']} to ${result1['targetLanguage']})');

  var result2 = ArabicEnglishConverter.autoConvert('mrhba');
  print('mrhba -> ${result2['converted']} (${result2['sourceLanguage']} to ${result2['targetLanguage']})');

  // Test mixed content
  print('\nMixed content:');
  print('Hello مرحبا World -> ${ArabicEnglishConverter.arabicToEnglish('Hello مرحبا World')}');
}


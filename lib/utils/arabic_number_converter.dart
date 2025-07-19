
// Create a helper function to convert English numbers to Arabic numerals:
// converting first from int to string and then split if more than one digit.
// Converts an integer into Arabic-Indic digits (e.g., 24 → ٢٤).
String convertToArabicNumber(int number) {
  const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
  return number.toString().split('').map((e) => arabicDigits[int.parse(e)]).join();
}
class IslamicRadioModel {
  final int id;
  final String islamicRadioListName;
  final String islamicRadioIcon;
  final String islamicRadioCountryName;
  final String islamicRadioCountryFlag;
  final String islamicRadioStreamUrl;

  IslamicRadioModel(
      this.islamicRadioIcon,
      this.islamicRadioCountryName,
      this.islamicRadioCountryFlag,
      {
        required this.islamicRadioStreamUrl,
        required this.id,
        required this.islamicRadioListName
      }
      );
}

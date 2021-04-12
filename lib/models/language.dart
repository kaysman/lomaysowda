final List<LanguageModel> languages = [
  LanguageModel("English", "en"),
  LanguageModel("Türkmen", "tm"),
  LanguageModel("Pусский", "ru"),
];

class LanguageModel {
  LanguageModel(
    this.language,
    this.symbol,
  );

  String language;
  String symbol;
}

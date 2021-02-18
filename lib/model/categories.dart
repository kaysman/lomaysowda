class Category {
  final int id;
  final String name_tm;
  final String name_ru;
  final String name_en;

  Category({this.id, this.name_tm, this.name_ru, this.name_en});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? 0,
      name_tm: json['name_tm'] ?? '',
      name_ru: json['name_ru'] ?? '',
      name_en: json['name_en'] ?? '',
    );
  }

  static List<Category> listFromJson(List json) {
    return json.map((category) => Category.fromJson(category)).toList();
  }

  String getName(String languageCode) {
    if (languageCode == 'en') {
      return this.name_en;
    } else if (languageCode == 'ru') {
      return this.name_ru;
    } else if (languageCode == 'tk') {
      return name_tm;
    }
    throw Exception('product name yalnys');
  }
}

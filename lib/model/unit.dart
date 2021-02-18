class Unit {
  int id;
  String name_tm;
  String name_ru;
  String name_en;
  Unit({
    this.name_tm,
    this.name_en,
    this.name_ru,
  });
  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      name_tm: json['name_tm'],
      name_en: json['name_en'],
      name_ru: json['name_ru'],
    );
  }
  static List<Unit> listFromJson(List json) {
    return json.map((unit) => Unit.fromJson(unit)).toList();
  }

  @override
  bool operator ==(Object other) =>
      other is Unit && other.name_tm == this.name_tm;

  @override
  int get hashCode => this.name_tm.hashCode;
}

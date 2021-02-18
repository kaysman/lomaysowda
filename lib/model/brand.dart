class Brand {
  final int id;
  final String name;
  final String image;
  final int status;
  final int preview;

  Brand({
    this.id,
    this.name,
    this.image,
    this.status,
    this.preview,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      status: json['status'],
      preview: json['preview'],
    );
  }

  static List<Brand> listFromJson(List json) {
    return json.map((brand) => Brand.fromJson(brand)).toList();
  }
}

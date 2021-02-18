import 'package:flutter/widgets.dart';
import 'package:lomaysowdamuckup/generated/l10n.dart';

class Product {
  int id;
  String name_tm;
  String name_ru;
  String name_en;
  int price;
  String image;

  Product({
    this.id,
    this.name_tm,
    this.name_ru,
    this.name_en,
    this.image,
    this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name_tm: json['name_tm'],
      name_ru: json['name_ru'],
      name_en: json['name_en'],
      price: json['price'],
      image: json['image'],
    );
  }

  static List<Product> listFromJson(List json) {
    // print(json);
    return json.map((product) => Product.fromJson(product)).toList();
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

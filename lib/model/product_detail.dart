import 'dart:io';

class ProductDetail {
  int id;
  String name_tm;
  String name_ru;
  String name_en;
  String desc_tm;
  String desc_ru;
  String desc_en;
  int min_qua;
  int preview;
  int price;
  List images;
  int provider_id;
  String provider_name;
  String provider_email;
  String provider_phone;
  String provider_image;

  ProductDetail({
    this.id,
    this.name_tm,
    this.name_en,
    this.name_ru,
    this.desc_tm,
    this.desc_ru,
    this.desc_en,
    this.min_qua,
    this.preview,
    this.images,
    this.price,
    this.provider_id,
    this.provider_name,
    this.provider_email,
    this.provider_phone,
    this.provider_image,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      name_tm: json['name_tm'],
      name_ru: json['name_ru'],
      name_en: json['name_en'],
      desc_tm: json['desc_tm'],
      desc_ru: json['desc_ru'],
      desc_en: json['desc_en'],
      min_qua: json['min_qua'],
      preview: json['preview'],
      images: json['images'],
      price: json['price'],
      provider_id: json['provider_id'],
      provider_name: json['provider_name'],
      provider_email: json['provider_email'],
      provider_phone: json['provider_phone'],
      provider_image: json['provider_image'],
    );
  }

  String toString() {
    return '$name_tm product';
  }

  String nameByLocale() {
    final String defaultLocale = Platform.localeName;
    return defaultLocale.substring(0, 2);
  }
}

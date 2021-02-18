import 'package:flutter/material.dart';

class SliderImage {
  final int id;
  final String name;
  final String image;
  final int cat_id;
  final int status;
  final String created_at;

  SliderImage(
      {this.id,
      this.name,
      this.image,
      this.cat_id,
      this.status,
      this.created_at});

  factory SliderImage.fromJson(Map<String, dynamic> json) {
    return SliderImage(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        cat_id: json['cat_id'],
        status: json['status'],
        created_at: json['created_at']);
  }

  static List<SliderImage> listFromJson(List json) {
    return json.map((e) => SliderImage.fromJson(e)).toList();
  }
}

import 'package:lomaysowda/models/product.dart';
import 'brand.dart';

class SupplierModel {
  int id;
  String name;
  String image;
  String phone;
  String address;
  String website;
  int preview;
  BrandListModel brands;
  ProductListModel products;

  SupplierModel({
    this.id,
    this.name,
    this.image,
    this.phone,
    this.address,
    this.website,
    this.preview,
    this.brands,
    this.products,
  });

  SupplierModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        phone = json['phone'],
        address = json['address'],
        website = json['website'],
        preview = json['preview'],
        brands = BrandListModel.fromJson(json['brands']),
        products = ProductListModel.fromJson(json['products']);
}

// class SupplierListModel {
//   List<SupplierModel> list;

//   SupplierListModel({this.list});
//   factory SupplierListModel.fromJson(dynamic json) {
//     List list = (json as List).map((i) {
//       return SupplierModel.fromJson(i);
//     }).toList();

//     return SupplierListModel(list: list);
//   }
// }

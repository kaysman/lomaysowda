import 'package:lomaysowdamuckup/model/brand.dart';
import 'package:lomaysowdamuckup/model/product.dart';

class ProductProvider {
  int id;
  String name;
  String image;
  String phone;
  String address;
  String website;
  int preview;
  List<Brand> brands;
  List<Product> products;

  ProductProvider({
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

  factory ProductProvider.fromJson(Map<String, dynamic> json) {
    return ProductProvider(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      phone: json['phone'],
      address: json['address'],
      website: json['website'],
      preview: json['preview'],
      brands: Brand.listFromJson(json['brands']),
      products: Product.listFromJson(json['products']),
    );
  }
}

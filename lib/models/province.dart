import 'city.dart';

class ProvinceModel {
  String slug;
  String name;
  CityListModel cities;
  ProvinceModel({this.name, this.cities});
  ProvinceModel.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        cities = CityListModel.fromJson(json['cities']);
}

class ProvinceListModel {
  List<ProvinceModel> list;
  ProvinceListModel({this.list});
  factory ProvinceListModel.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return ProvinceModel.fromJson(item);
    }).toList();
    return ProvinceListModel(list: itemModals);
  }
}

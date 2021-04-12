import 'market.dart';

class CityModel {
  String slug;
  String name;
  MarketModelList markets;
  CityModel({this.name, this.markets});
  CityModel.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        markets = MarketModelList.fromJson(json['markets']);
}

class CityListModel {
  List<CityModel> list;
  CityListModel({this.list});
  factory CityListModel.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return CityModel.fromJson(item);
    }).toList();
    return CityListModel(list: itemModals);
  }
}

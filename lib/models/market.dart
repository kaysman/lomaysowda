class MarketModel {
  String slug;
  String name;
  String icon;
  MarketModel({this.name, this.icon});
  MarketModel.fromJson(Map<String, dynamic> json)
      : slug = json['slug'],
        name = json['name'],
        icon = json['icon'];
}

class MarketModelList {
  List<MarketModel> list;
  MarketModelList({this.list});
  factory MarketModelList.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return MarketModel.fromJson(item);
    }).toList();
    return MarketModelList(list: itemModals);
  }
}

class UnitModel {
  int id;
  String name_tm;
  String name_ru;
  String name_en;
  UnitModel({this.id, this.name_tm, this.name_ru, this.name_en});
  UnitModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name_tm = json['name_tm'],
        name_ru = json['name_ru'],
        name_en = json['name_en'];
  String getName(String languageCode) {
    if (languageCode == 'en') {
      return this.name_en;
    } else if (languageCode == 'tm') {
      return this.name_tm;
    } else {
      return this.name_ru;
    }
  }
}

class UnitModelList {
  List<UnitModel> list;
  UnitModelList({this.list});
  factory UnitModelList.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return UnitModel.fromJson(item);
    }).toList();
    return UnitModelList(list: itemModals);
  }
}

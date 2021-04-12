class CategoryModel {
  int id;
  String name_tm;
  String name_ru;
  String name_en;
  String icon;
  CategoryModel({this.id, this.name_tm, this.name_ru, this.name_en, this.icon});
  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name_tm = json['name_tm'],
        name_ru = json['name_ru'],
        name_en = json['name_en'],
        icon = json['icon'];
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

class CategoryModelList {
  List<CategoryModel> list;
  CategoryModelList({this.list});
  factory CategoryModelList.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return CategoryModel.fromJson(item);
    }).toList();
    return CategoryModelList(list: itemModals);
  }
}

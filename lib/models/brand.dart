class BrandModel {
  int id;
  String name;
  String image;
  int status;
  int preview;

  BrandModel({this.id, this.name, this.image, this.status, this.preview});

  BrandModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        image = json['image'],
        status = json['status'],
        preview = json['preview'];
}

class BrandListModel {
  List<BrandModel> list;
  BrandListModel({this.list});
  factory BrandListModel.fromJson(dynamic json) {
    var items = json as List;
    var itemModels = items.map((item) {
      return BrandModel.fromJson(item);
    }).toList();
    return BrandListModel(list: itemModels);
  }
}

class SliderModel {
  int id;
  String name;
  String image;
  int categoryId;
  SliderModel({
    this.id,
    this.name,
    this.image,
    this.categoryId,
  });
  SliderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json["name"],
        image = json['image'],
        categoryId = json['cat_id'];
}

class SliderListModel {
  List<SliderModel> list;
  SliderListModel({this.list});
  factory SliderListModel.fromJson(dynamic json) {
    List list = (json as List).map((i) {
      return SliderModel.fromJson(i);
    }).toList();
    return SliderListModel(list: list);
  }
}

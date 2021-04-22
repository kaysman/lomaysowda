class OrderModel {
  int id;
  String name;
  String phone;
  String message;
  int productId;
  int userId;
  int status;
  String createdAt;

  OrderModel({
    this.id,
    this.name,
    this.phone,
    this.message,
    this.productId,
    this.userId,
    this.status,
    this.createdAt,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        message = json['message'],
        productId = json['product_id'],
        userId = json['user_id'],
        status = json['status'],
        createdAt = json['created_at'];
}

class OrderModelList {
  List<OrderModel> list;
  OrderModelList({this.list});
  factory OrderModelList.fromJson(dynamic json) {
    var items = json as List;
    var itemModals = items.map((item) {
      return OrderModel.fromJson(item);
    }).toList();
    return OrderModelList(list: itemModals);
  }
}

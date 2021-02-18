class Order {
  int id;
  String name;
  String phone;
  String message;
  int product_id;
  int user_id;
  int status;
  String created_at;
  Order({
    this.id,
    this.name,
    this.phone,
    this.message,
    this.product_id,
    this.user_id,
    this.status,
    this.created_at,
  });
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      message: json['message'],
      product_id: json['product_id'],
      user_id: json['user_id'],
      status: json['status'],
      created_at: json['created_at'],
    );
  }
  static List<Order> listFromJson(List json) {
    return json.map((order) => Order.fromJson(order)).toList();
  }
}

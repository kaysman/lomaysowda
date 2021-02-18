class User {
  int id;
  String name;
  String email;
  String email2;
  String phone;
  String phone2;
  String image;
  String address;
  String website;
  int type_id;
  int city_id;
  int checked;
  int trusted;
  int preview;
  String email_verified_at;
  String created_at;

  User({
    this.id,
    this.name,
    this.email,
    this.email2,
    this.phone,
    this.phone2,
    this.image,
    this.address,
    this.website,
    this.type_id,
    this.city_id,
    this.checked,
    this.trusted,
    this.preview,
    this.email_verified_at,
    this.created_at,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      id: responseData['id'],
      name: responseData['name'],
      email: responseData['email'],
      email2: responseData['email2'] ?? '',
      phone: responseData['phone'] ?? '',
      phone2: responseData['phone2'] ?? '',
      image: responseData['image'],
      address: responseData['address'] ?? '',
      website: responseData['website'] ?? '',
      type_id: responseData['type_id'],
      city_id: responseData['city_id'],
      checked: responseData['checked'],
      trusted: responseData['trusted'],
      preview: responseData['preview'],
      email_verified_at: responseData['email_verified_at'] ?? '',
      created_at: responseData['created_at'] ?? '',
    );
  }
}

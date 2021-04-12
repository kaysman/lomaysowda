class DetailItemModel {
  int id, preview, supplier_id;
  List images;
  String picurl,
      name_tm,
      name_ru,
      name_en,
      price,
      min_qua,
      desc_tm,
      desc_en,
      desc_ru,
      supplier_name,
      supplier_email,
      supplier_phone,
      supplier_image;
  DetailItemModel({
    this.id,
    this.picurl,
    this.name_en,
    this.name_ru,
    this.name_tm,
    this.min_qua,
    this.preview,
    this.price,
    this.images,
    this.desc_tm,
    this.desc_ru,
    this.desc_en,
    this.supplier_id,
    this.supplier_name,
    this.supplier_email,
    this.supplier_image,
    this.supplier_phone,
  });
  DetailItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        picurl = json['image'],
        name_tm = json['name_tm'] ?? "",
        name_ru = json['name_ru'] ?? "",
        name_en = json['name_en'] ?? "",
        min_qua = json['min_qua'],
        preview = json['preview'],
        images = json['images'],
        desc_tm = json['desc_tm'],
        desc_ru = json['desc_ru'],
        desc_en = json['desc_en'],
        supplier_id = json['provider_id'],
        supplier_name = json['provider_name'],
        supplier_email = json['provider_email'],
        supplier_image = json['provider_image'],
        supplier_phone = json['provider_phone'];

  String getName(String languageCode) {
    if (languageCode == 'en') {
      return this.name_en;
    } else if (languageCode == 'tm') {
      return this.name_tm;
    } else {
      return this.name_ru;
    }
  }

  String getDesc(String languageCode) {
    if (languageCode == 'en') {
      return this.desc_en;
    } else if (languageCode == 'tm') {
      return this.desc_tm;
    } else {
      return this.desc_ru;
    }
  }
}

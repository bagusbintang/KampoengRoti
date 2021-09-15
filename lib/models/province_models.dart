class ProvinceModel {
  int id;
  String provinceName;

  ProvinceModel({
    this.id,
    this.provinceName,
  });

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    id = json['province_id'];
    provinceName = json['province_title'];
  }

  Map<String, dynamic> toJson() {
    return {
      'province_id': id,
      'province_title': provinceName,
    };
  }
}

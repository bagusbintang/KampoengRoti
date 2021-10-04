class UserAddressModel {
  //TODO : MENAMBAHKAN LATITUDE DAN LONGITUDE PADA MODEL INI !
  int id;
  int userId;
  String tagAddress;
  String personName;
  String personPhone;
  String address;
  String city;
  String province;
  int defaultAddress;
  double latitude;
  double longitude;

  UserAddressModel({
    this.id,
    this.userId,
    this.tagAddress,
    this.personName,
    this.personPhone,
    this.address,
    this.city,
    this.province,
    this.defaultAddress,
    this.latitude,
    this.longitude,
  });

  UserAddressModel.fromJson(Map<String, dynamic> json) {
    id = json["caddress_id"];
    userId = json["caddress_customerid"];
    tagAddress = json["caddress_tag"];
    personName = json["caddress_name"];
    personPhone = json["caddress_phone"];
    address = json["caddress_address"];
    city = json["caddress_city"];
    province = json["caddress_province"];
    defaultAddress = json["caddress_default"];
    if (json['latitude'] != null && json['longitude'] != null) {
      latitude = double.parse(json['latitude'].toString());
      longitude = double.parse(json['longitude'].toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'caddress_id': id,
      'caddress_customerid': userId,
      'caddress_tag': tagAddress,
      'caddress_name': personName,
      'caddress_phone': personPhone,
      'caddress_address': address,
      'caddress_city': city,
      'caddress_province': province,
      'caddress_default': defaultAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class UserAddressModel {
  int id;
  int userId;
  String tagAddress;
  String personName;
  String personPhone;
  String address;
  String city;
  String province;
  int defaultAddress;

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
    };
  }
}

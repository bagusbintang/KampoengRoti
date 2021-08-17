class OutletModel {
  int id;
  int cityId;
  String title;
  String address;
  String phone;
  Uri url;

  OutletModel({
    this.id,
    this.cityId,
    this.title,
    this.address,
    this.phone,
    this.url,
  });

  OutletModel.fromJson(Map<String, dynamic> outletJson) {
    id = outletJson['outlet_id'];
    cityId = outletJson['outlet_cityid'];
    title = outletJson['outlet_title'];
    address = outletJson['outlet_address'];
    phone = outletJson['outlet_phone'];
  }

  Map<String, dynamic> toJson() {
    return {
      'outlet_id': id,
      'outlet_cityid': cityId,
      'outlet_title': title,
      'outlet_address': address,
      'outlet_phone': phone,
    };
  }
}

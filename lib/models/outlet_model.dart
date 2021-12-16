class OutletModel {
  int id;
  int cityId;
  String title;
  String address;
  String phone;
  double latitude;
  double longitude;
  String url;
  double distance;

  OutletModel({
    this.id,
    this.cityId,
    this.title,
    this.address,
    this.phone,
    this.latitude,
    this.longitude,
    this.url,
    this.distance,
  });

  OutletModel.fromJson(Map<String, dynamic> outletJson) {
    id = outletJson['outlet_id'];
    cityId = outletJson['outlet_cityid'];
    title = outletJson['outlet_title'];
    address = outletJson['outlet_address'];
    phone = outletJson['outlet_phone'];
    url = outletJson['outlet_map'].toString();
    latitude = double.parse(outletJson['outlet_latitude'].toString());
    longitude = double.parse(outletJson['outlet_longitude'].toString());
    if (outletJson['distance_in_km'] != null) {
      distance = double.parse(outletJson['distance_in_km'].toString());
    } else {
      distance = 0;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'outlet_id': id,
      'outlet_cityid': cityId,
      'outlet_title': title,
      'outlet_address': address,
      'outlet_phone': phone,
      'outlet_map': url,
      'outlet_latitude': latitude,
      'outlet_longitude': longitude,
      'distance_in_km': distance,
    };
  }
}

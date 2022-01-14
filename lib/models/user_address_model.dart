import 'package:kampoeng_roti/models/outlet_model.dart';

class UserAddressModel {
  int id;
  int userId;
  String tagAddress;
  String personName;
  String personPhone;
  String address;
  String city;
  String province;
  String notes;
  int defaultAddress;
  double latitude;
  double longitude;
  OutletModel outletModel;

  UserAddressModel({
    this.id,
    this.userId,
    this.tagAddress,
    this.personName,
    this.personPhone,
    this.address,
    this.city,
    this.province,
    this.notes,
    this.defaultAddress,
    this.latitude,
    this.longitude,
    this.outletModel,
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
    notes = json["caddress_catatan"];
    defaultAddress = json["caddress_default"];
    if (json['latitude'] != null && json['longitude'] != null) {
      latitude = double.parse(json['latitude'].toString());
      longitude = double.parse(json['longitude'].toString());
    }
    if (json['outlet_data'] != null && json['outlet_data'] != '') {
      outletModel = OutletModel.fromJson(json['outlet_data']);
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
      'caddress_catatan': notes,
      'caddress_default': defaultAddress,
      'latitude': latitude,
      'longitude': longitude,
      outletModel == null ? 'outlet_data' : outletModel.toJson(): '',
    };
  }
}

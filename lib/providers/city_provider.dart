import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/services/city_service.dart';

class CityProvider with ChangeNotifier {
  List<CityModel> _city = [];

  List<CityModel> get city => _city;

  set city(List<CityModel> city) {
    _city = city;
    notifyListeners();
  }

  Future<void> getCity({
    int provinceId = 11,
  }) async {
    try {
      List<CityModel> city =
          await CityService().getCity(provinceId: provinceId);
      _city = city;
    } catch (e) {
      print(e);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/province_models.dart';
import 'package:kampoeng_roti/services/province_service.dart';

class ProvinceProvider with ChangeNotifier {
  List<ProvinceModel> _provinces = [];

  List<ProvinceModel> get provinces => _provinces;

  set provinces(List<ProvinceModel> provinces) {
    _provinces = provinces;
    notifyListeners();
  }

  Future<void> getProvinces() async {
    try {
      List<ProvinceModel> provinces = await ProvinceService().getProvince();
      _provinces = provinces;
    } catch (e) {
      print(e);
    }
  }
}

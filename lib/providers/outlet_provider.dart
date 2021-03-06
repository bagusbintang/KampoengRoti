import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/services/outlet_service.dart';

class OutletProvider with ChangeNotifier {
  List<OutletModel> _outlets = [];

  List<OutletModel> get outlets => _outlets;

  set outlets(List<OutletModel> outlets) {
    _outlets = outlets;
    notifyListeners();
  }

  Future<void> getOutlets({
    int city_id = 0,
    double latitude,
    double longitude,
  }) async {
    try {
      List<OutletModel> outlets = await OutletService().getOutlets(
          cityId: city_id, latitude: latitude, longitude: longitude);
      _outlets = outlets;
    } catch (e) {
      print(e);
    }
  }
}

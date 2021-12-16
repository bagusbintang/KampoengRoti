import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/promo_model.dart';
import 'package:kampoeng_roti/services/promo_service.dart';

class PromoProvider with ChangeNotifier {
  List<PromoModel> _promos = [];

  List<PromoModel> get promos => _promos;

  set promos(List<PromoModel> promos) {
    _promos = promos;
    notifyListeners();
  }

  Future<void> getPromos({
    int userId,
  }) async {
    try {
      List<PromoModel> promos = await PromoService().getPromo(userId: userId);
      _promos = promos;
    } catch (e) {
      print(e);
    }
  }
}

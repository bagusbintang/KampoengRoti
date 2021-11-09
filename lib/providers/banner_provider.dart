import 'package:flutter/cupertino.dart';
import 'package:kampoeng_roti/models/banner_model.dart';
import 'package:kampoeng_roti/services/banner_service.dart';

class BannerProvider with ChangeNotifier {
  List<BannerModel> _banners = [];

  List<BannerModel> get banners => _banners;

  set banners(List<BannerModel> banners) {
    _banners = banners;
    notifyListeners();
  }

  Future<void> getBanners() async {
    try {
      List<BannerModel> banners = await BannerService().getBanner();
      _banners = banners;
    } catch (e) {
      print(e);
    }
  }
}

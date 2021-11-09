import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/services/category_service.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];

  List<CategoryModel> get categories => _categories;

  set categories(List<CategoryModel> categories) {
    _categories = categories;
    notifyListeners();
  }

  Future<void> getCategories({
    int outletId,
  }) async {
    try {
      List<CategoryModel> categories =
          await CategoryService().getCategory(outletId: outletId);
      _categories = categories;
    } catch (e) {
      print(e);
    }
  }
}

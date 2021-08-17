import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/faq_model.dart';
import 'package:kampoeng_roti/services/faq_service.dart';

class FaqProvider with ChangeNotifier {
  List<FaqModel> _faqs = [];

  List<FaqModel> get faqs => _faqs;

  set faqs(List<FaqModel> faqs) {
    _faqs = faqs;
    notifyListeners();
  }

  Future<void> getFaqs() async {
    try {
      List<FaqModel> faqs = await FaqService().getFaq();
      _faqs = faqs;
    } catch (e) {
      print(e);
    }
  }
}

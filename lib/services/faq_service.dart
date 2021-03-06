import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/faq_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class FaqService {
  Future<List<FaqModel>> getFaq() async {
    var response = await http.get(Uri.parse(faqUrl), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<FaqModel> faqs = [];

      for (var item in data) {
        faqs.add(FaqModel.fromJson(item));
      }

      return faqs;
    } else {
      throw Exception('Gagal mendapat kan data FAQ!');
    }
  }
}

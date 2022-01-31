import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kampoeng_roti/models/invoice_model.dart';
import 'package:kampoeng_roti/services/services.dart';

class OrderService {
  Future<void> checkOut({
    int userId,
    int deliveryMethod,
    int addressId,
    int outletId,
    int promoId,
    double shippingCosts,
    double promoDisc,
    double memberDisc,
    String deliveryTime,
    String paymenMethod,
    String note,
    double total,
    double grandTotal,
  }) async {
    var body = jsonEncode({
      'delivery_method': deliveryMethod,
      'caddress_id': addressId,
      'outlet_id': outletId,
      'promoid': promoId,
      'ongkir': shippingCosts,
      'promodiscount': promoDisc,
      'memberdiscount': memberDisc,
      'deliverytime': deliveryTime,
      'payment_method': paymenMethod,
      'note': note,
      'total': total,
      'grandtotal': grandTotal,
    });

    var response = await http.post(
      Uri.parse("$checkoutUrl/${userId}"),
      headers: headers,
      body: body,
    );

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];

      print(data);
    } else {
      throw Exception('Gagal Menembak data Invoice');
    }
  }

  Future<List<InvoiceModel>> getInvoice({
    int userId = 1,
    int status,
  }) async {
    final url = Uri.encodeFull("$getInvoiceUrl/${userId}/${status}");
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    print(response.body);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)['data']['respons_res'];
      List<InvoiceModel> invoice = [];

      for (var item in data) {
        // if  (item.containsKey()){}
        invoice.add(InvoiceModel.fromJson(item));
      }

      return invoice;
    } else {
      throw Exception('Gagal mendapat kan data Invoice!');
    }
  }
}

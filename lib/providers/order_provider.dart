import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/invoice_model.dart';
import 'package:kampoeng_roti/services/order_service.dart';

class OrderProvider with ChangeNotifier {
  List<InvoiceModel> _invoice = [];

  List<InvoiceModel> get invoices => _invoice;

  set invoices(List<InvoiceModel> invoices) {
    _invoice = invoices;
    notifyListeners();
  }

  Future<void> getInvoices({
    int userId,
    int status,
  }) async {
    try {
      List<InvoiceModel> invoices =
          await OrderService().getInvoice(userId: userId, status: status);
      _invoice = invoices;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> checkOut({
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
    try {
      await OrderService().checkOut(
        userId: userId,
        deliveryMethod: deliveryMethod,
        addressId: addressId,
        outletId: outletId,
        promoId: promoId,
        shippingCosts: shippingCosts,
        promoDisc: promoDisc,
        memberDisc: memberDisc,
        deliveryTime: deliveryTime,
        paymenMethod: paymenMethod,
        note: note,
        total: total,
        grandTotal: grandTotal,
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

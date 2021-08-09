import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/detail_order.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class DeliveryTransaction {
  String imageUrl;
  String invoice;
  int statusInvoice;
  String date;
  String itemName;
  int statusOrder;

  DeliveryTransaction(this.imageUrl, this.invoice, this.statusInvoice,
      this.date, this.itemName, this.statusOrder);
}

class DeliveryTransactionContainer extends StatelessWidget {
  const DeliveryTransactionContainer({
    Key key,
    this.imageUrl,
    this.invoice,
    this.statusInvoice,
    this.date,
    this.itemName,
    this.statusOrder,
  }) : super(key: key);
  final String imageUrl;
  final String invoice;
  final int statusInvoice;
  final String date;
  final String itemName;
  final int statusOrder;

  @override
  Widget build(BuildContext context) {
    Color _colorStatus;
    String _invoiceStatus;
    String _orderStatus;

    if (statusInvoice == 1 && statusOrder == 1) {
      _colorStatus = Colors.amber;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "Konfirmasi Pembayaran";
    } else if (statusInvoice == 1 && statusOrder == 2) {
      _colorStatus = Colors.amber;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "Menunggu Konfirmasi";
    } else if (statusInvoice == 1 && statusOrder == 3) {
      _colorStatus = Colors.red;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "Pesanan Diterima";
    } else if (statusInvoice == 2 && statusOrder == 1) {
      _colorStatus = Colors.orange;
      _invoiceStatus = "Pickup Order";
      _orderStatus = "Konfirmasi Pembayaran";
    } else if (statusInvoice == 2 && statusOrder == 2) {
      _colorStatus = Colors.orange;
      _invoiceStatus = "Pickup Order";
      _orderStatus = "Menunggu Konfirmasi";
    } else if (statusInvoice == 2 && statusOrder == 3) {
      _colorStatus = Colors.orange;
      _invoiceStatus = "Pickup Order";
      _orderStatus = "Pesanan Diterima";
    }
    return GestureDetector(
      onTap: () {
        Get.to(
          () => DetailOrder(),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: _colorStatus,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
              ),
              child: Center(
                child: Text(
                  _invoiceStatus,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      Text(
                        invoice,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                    ),
                    child: Text(
                      _orderStatus,
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Image.asset(
                    imageUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer(),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text(
                        itemName,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "(+3 Produk lainnya)",
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Total Pembayaran",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Rp. 75.000",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: choclateColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/detail_history_transaction.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class HistoryOrder {
  String imageUrl;
  String invoice;
  int statusInvoice;
  String date;
  String time;
  int statusOrder;

  HistoryOrder(this.imageUrl, this.invoice, this.statusInvoice, this.date,
      this.time, this.statusOrder);
}

class HistoryContainer extends StatelessWidget {
  const HistoryContainer({
    Key key,
    this.imageUrl,
    this.invoice,
    this.statusInvoice,
    this.date,
    this.time,
    this.statusOrder,
  }) : super(key: key);
  final String imageUrl;
  final String invoice;
  final int statusInvoice;
  final String date;
  final String time;
  final int statusOrder;

  @override
  Widget build(BuildContext context) {
    Color _colorStatus;
    String _invoiceStatus;
    String _orderStatus;

    if (statusInvoice == 1 && statusOrder == 1) {
      _colorStatus = Colors.amber;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "ONGOING";
    } else if (statusInvoice == 1 && statusOrder == 2) {
      _colorStatus = Colors.amber;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "COMPLETED";
    } else if (statusInvoice == 1 && statusOrder == 3) {
      _colorStatus = Colors.red;
      _invoiceStatus = "Delivery Order";
      _orderStatus = "CANCELLED";
    } else if (statusInvoice == 2 && statusOrder == 1) {
      _colorStatus = Colors.orange;
      _invoiceStatus = "Pickup Order";
      _orderStatus = "ONGOING";
    } else if (statusInvoice == 2 && statusOrder == 2) {
      _colorStatus = Colors.orange;
      _invoiceStatus = "Pickup Order";
      _orderStatus = "COMPLETED";
    }

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.to(DetailHistoryTransaction(), arguments: [
          invoice,
          date,
          time,
          statusInvoice,
        ]);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            )),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ImageIcon(
                AssetImage(
                  imageUrl,
                ),
                color: _colorStatus,
                size: 40,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        invoice,
                        style: TextStyle(
                          fontSize: 12,
                          color: choclateColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: _colorStatus,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(0),
                            )),
                        child: Text(
                          _invoiceStatus.toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Jl. Prambanan Residence Maharaja CD-05",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.calendar_today,
                                size: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            TextSpan(
                              text: date,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.access_time,
                                size: 12,
                                color: Colors.grey[400],
                              ),
                            ),
                            TextSpan(
                              text: time,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        _orderStatus,
                        style: TextStyle(
                            fontSize: 12,
                            color: _colorStatus,
                            fontWeight: FontWeight.w600),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

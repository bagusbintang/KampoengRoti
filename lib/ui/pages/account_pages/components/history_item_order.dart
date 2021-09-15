import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/invoice_detail_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class HistoryItemOrder extends StatelessWidget {
  const HistoryItemOrder({
    Key key,
    this.invoiceDetailModel,
  }) : super(key: key);
  final InvoiceDetailModel invoiceDetailModel;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    return Column(
      children: <Widget>[
        const Divider(
          height: 20,
          thickness: 1,
        ),
        Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                invoiceDetailModel.imageUrl,
                height: 120,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${invoiceDetailModel.qty}x",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: choclateColor,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          invoiceDetailModel.title,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          // "Rp 20.000",
                          "Rp. ${currencyFormatter.format(invoiceDetailModel.subTotal)}",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: choclateColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Rp ${currencyFormatter.format(invoiceDetailModel.price)} / biji",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: choclateColor,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

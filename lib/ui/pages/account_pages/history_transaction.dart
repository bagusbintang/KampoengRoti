import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/history_container.dart';

class HistoryTransaction extends StatelessWidget {
  List<HistoryOrder> historyList = [
    HistoryOrder(
      "assets/images/icon_delivery_ongoing.png",
      "INV12162462/040842148",
      1,
      "12 December 2020",
      "10:02 PM",
      1,
    ),
    HistoryOrder(
      "assets/images/icon_delivery_completed.png",
      "INV12162462/040842148",
      2,
      "12 December 2020",
      "10:02 PM",
      2,
    ),
    HistoryOrder(
      "assets/images/icon_delivery_ongoing.png",
      "INV12162462/040842148",
      1,
      "12 December 2020",
      "10:02 PM",
      2,
    ),
    HistoryOrder(
      "assets/images/icon_delivery_ongoing.png",
      "INV12162462/040842148",
      1,
      "12 December 2020",
      "10:02 PM",
      3,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Riwayat Transaksi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {},
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: List.generate(
                  historyList.length,
                  (index) => HistoryContainer(
                    imageUrl: historyList[index].imageUrl,
                    invoice: historyList[index].invoice,
                    statusInvoice: historyList[index].statusInvoice,
                    date: historyList[index].date,
                    time: historyList[index].time,
                    statusOrder: historyList[index].statusOrder,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

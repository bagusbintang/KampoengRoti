import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/category_status.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_transaction_container.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class DetailTransaction extends StatelessWidget {
  List<DeliveryTransaction> historyList = [
    DeliveryTransaction(
      "assets/images/product_1.png",
      "INV20190412/0002384",
      1,
      "12 Dec 2021",
      "Roti Baper Coklat",
      1,
    ),
    DeliveryTransaction(
      "assets/images/product_1.png",
      "INV20190412/0002384",
      2,
      "12 Dec 2021",
      "Roti Baper Coklat",
      2,
    ),
    DeliveryTransaction(
      "assets/images/product_1.png",
      "INV20190412/0002384",
      2,
      "12 Dec 2021",
      "Roti Baper Coklat",
      1,
    ),
    DeliveryTransaction(
      "assets/images/product_1.png",
      "INV20190412/0002384",
      1,
      "12 Dec 2021",
      "Roti Baper Coklat",
      2,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Daftar Transaksi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: textFieldSearchTransaction(
                    "Cari Invoice, daftar transaksi, konfirmasi barang",
                    Icon(Icons.search)),
              ),
              SizedBox(
                height: 15,
              ),
              CategoryStatus(),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              Container(
                child: Column(
                  children: List.generate(
                    historyList.length,
                    (index) => DeliveryTransactionContainer(
                      imageUrl: historyList[index].imageUrl,
                      invoice: historyList[index].invoice,
                      statusInvoice: historyList[index].statusInvoice,
                      date: historyList[index].date,
                      itemName: historyList[index].itemName,
                      statusOrder: historyList[index].statusOrder,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Theme textFieldSearchTransaction(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 12),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[400]),
            hintText: text,
            suffixIcon: icon,
            fillColor: Colors.white),
      ),
    );
  }
}

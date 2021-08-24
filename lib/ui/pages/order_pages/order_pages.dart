import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/item_order.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_detail.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class OrderPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
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
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Ringkasan Pesanan",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    child: Text("+ Tambah"),
                    style: TextButton.styleFrom(
                      primary: softOrangeColor,
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Container(
              child: Column(
                children: List.generate(
                  3,
                  (index) => ItemOrder(),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Sub-Total",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Rp 125.000",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: softOrangeColor,
                    ),
                  ),
                ],
              ),
            ),
            // DeliveryWay(),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  DefaultButton(
                    text: "LANJUTKAN",
                    press: () {
                      Get.to(() => OrderDetail());
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Dengan menekan tombol diatas, saya menyetujui untuk\nsyarat dan ketentuan yang berlaku",
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_contact_us.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_edit_profile.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_faq.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/account_info.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/history_transaction.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_address.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class AccountPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 25),
              height: size.height / 5,
              width: size.width,
              decoration: BoxDecoration(
                color: softOrangeColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: null,
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: softOrangeColor,
                      size: 70,
                    ),
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Bima Aprianto Siono",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "bima.aprianto@gmail.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "+6281804643014",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Get.to(() => EditProfile());
                          },
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "ubah profile",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AccountInfo(
              titleName: "Riwayat Transaksi",
              icon: Icon(
                Icons.history_edu,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(() => HistoryTransaction());
              },
            ),
            AccountInfo(
              titleName: "Alamat",
              icon: Icon(
                Icons.location_on,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(() => DeliveryAddress());
              },
            ),
            AccountInfo(
              titleName: "Promo",
              icon: Icon(
                Icons.next_plan,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {},
            ),
            AccountInfo(
              titleName: "Bagi Aplikasi",
              icon: Icon(
                Icons.share,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {},
            ),
            AccountInfo(
              titleName: "Member Kampoeng Roti",
              icon: Icon(
                Icons.credit_card,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {},
            ),
            AccountInfo(
              titleName: "FAQ",
              icon: Icon(
                Icons.question_answer,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(() => AccountFAQ());
              },
            ),
            AccountInfo(
              titleName: "Hubungi Kami",
              icon: Icon(
                Icons.call,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(() => AccountContactUs());
              },
            ),
            AccountInfo(
              titleName: "Keluar",
              icon: Icon(
                Icons.logout,
                size: 40,
                color: softOrangeColor,
              ),
              pressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

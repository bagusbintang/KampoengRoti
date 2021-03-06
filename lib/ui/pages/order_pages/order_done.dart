import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_contact_us.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/order_done_header.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class OrderDone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    dynamic data = Get.arguments;
    bool isDeliv = data[1];
    DateTime date = data[0];
    var formatDate = DateFormat('d MMMM yyyy');
    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/images/kr_background.png"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            OrderDoneHeader(
              size: size,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                    ),
                    Image(
                      image: AssetImage(
                        "assets/images/appointment.png",
                      ),
                      height: 80,
                      width: 80,
                      color: choclateColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      width: 150,
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 20),
                      decoration: BoxDecoration(
                          color: choclateColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                      child: Center(
                        child: Text(
                          isDeliv
                              ? "Delivery Order".toUpperCase()
                              : "Pick Up".toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      isDeliv
                          ? "Terima Kasih, pesanan Anda akan diantar :"
                          : "Terima Kasih, pesanan Anda siap diambil :",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      // "SELASA. 12 MEI 2021 Pk. 10.00",
                      "${formatDate.format(date)} Pk. ${DateFormat.Hm().format(date)}",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: choclateColor,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Jika ada perubahan, kami akan memberitahu\nAnda secepatnya, dikolom notifikasi",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "*syarat dan ketentuan berlaku",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    DefaultButton(
                      text: "KEMBALI KE HALAMAN UTAMA",
                      press: () {
                        Get.back();
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      text: "HUBUNGI ADMIN",
                      press: () {
                        Get.to(AccountContactUs());
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

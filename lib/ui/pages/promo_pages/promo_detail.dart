import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/promo_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class PromoDetail extends StatelessWidget {
  const PromoDetail({
    Key key,
    this.promo,
    this.used,
    this.fromPaymentPage,
  }) : super(key: key);
  final PromoModel promo;
  final bool used;
  final bool fromPaymentPage;

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    print(used);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promo Kampoeng Roti",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          promoHeader(size),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: double.maxFinite,
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 30,
                              color: choclateColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Masa Berlaku",
                                  style: TextStyle(
                                    color: choclateColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  // "12 Jan 2019",
                                  convertDateTimeDisplay(promo.end.toString()),
                                  style: TextStyle(
                                    // color: softOrangeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 1,
                    height: double.maxFinite,
                    color: choclateColor,
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: double.maxFinite,
                      margin: EdgeInsets.fromLTRB(10, 20, 0, 20),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 30,
                              color: choclateColor,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Nama Promo",
                                  style: TextStyle(
                                    color: choclateColor,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  // "PROMOGET",
                                  promo.title,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    // color: softOrangeColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            width: double.maxFinite,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 0,
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    // "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
                    promo.desc,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
                  //   style: TextStyle(
                  //     fontSize: 12,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Spacer(),
          Visibility(
            visible: fromPaymentPage,
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: DefaultButton(
                press: () {
                  Get.back(result: used ? null : promo);
                },
                text: used ? "BATALKAN" : "PAKAI",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container promoHeader(Size size) {
    return promo.imageUrl == null
        ? Container(
            height: size.height / 5,
            width: size.width,
            decoration: BoxDecoration(
              color: softOrangeColor,
            ),
            child: Stack(
              children: [
                Center(
                  child: Image(
                    image: AssetImage(
                      "assets/images/ic_promo.png",
                    ),
                    height: 80,
                    width: 80,
                  ),
                ),
                // Positioned(
                //   bottom: 0,
                //   right: 0,
                //   child: Container(
                //     width: 50,
                //     padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                //     margin: EdgeInsets.symmetric(vertical: 15),
                //     decoration: BoxDecoration(
                //         color: Colors.grey[300],
                //         borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(30),
                //           topRight: Radius.circular(0),
                //           bottomLeft: Radius.circular(30),
                //           bottomRight: Radius.circular(0),
                //         )),
                //     child: Text(
                //       "x1",
                //       style: TextStyle(
                //         fontSize: 18,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        : Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              color: Colors.white,
            ),
            child: SizedBox(
              height: 100,
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
                child: Image.network(
                  promo.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }
}

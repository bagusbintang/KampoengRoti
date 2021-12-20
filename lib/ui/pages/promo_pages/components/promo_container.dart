import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/promo_model.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_detail.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class PromoContainer extends StatelessWidget {
  const PromoContainer({
    Key key,
    this.promoModel,
    this.press,
    this.fromPaymentPage,
  }) : super(key: key);
  final PromoModel promoModel;
  final Function press;
  final bool fromPaymentPage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(PromoDetail(
          promo: promoModel,
          used: false,
          fromPaymentPage: fromPaymentPage,
        )).then((value) => Get.back(result: value));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: iconImage(),
            ),
            Flexible(
              flex: 2,
              child: promoBody(),
            ),
            Flexible(
              flex: 1,
              child: promoCounter(),
            ),
          ],
        ),
      ),
    );
  }

  Widget iconImage() {
    return promoModel.imageUrl == null
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(0),
              ),
              color: softOrangeColor,
            ),
            child: Center(
              child: Image(
                image: AssetImage(
                  "assets/images/ic_promo.png",
                ),
                height: 80,
                width: 80,
              ),
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
                  promoModel.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
  }

  Widget promoBody() {
    return Container(
      padding: EdgeInsets.only(
        left: 10,
        top: 15,
        bottom: 15,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   "Promo",
          //   style: TextStyle(
          //     color: softOrangeColor,
          //     fontSize: 12,
          //   ),
          // ),
          Text(
            // "BELIPERTAMA",
            promoModel.title,
            style: TextStyle(
              color: choclateColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Text(
          //   // "Dapatkan diskon 10% untuk pembelian pertama anda di Kampoeng Roti",
          //   promoModel.desc,
          //   style: TextStyle(
          //     // color: softOrangeColor,
          //     fontSize: 10,
          //     fontWeight: FontWeight.w600,
          //   ),
          // ),
          Spacer(),
          Row(
            children: <Widget>[
              Icon(
                Icons.access_time,
                size: 20,
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
                    convertDateTimeDisplay(promoModel.end.toString()),
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
        ],
      ),
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  Widget promoCounter() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(
                  "assets/images/kr_logo.png",
                ),
                height: 50,
                width: 50,
              ),
              Spacer(),
              Visibility(
                visible: fromPaymentPage,
                child: InkWell(
                  onTap: () {
                    Get.back(result: promoModel);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: softOrangeColor,
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 5,
                    ),
                    child: Text(
                      "Pakai",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
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
}

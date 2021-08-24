import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_detail.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class PromoContainer extends StatelessWidget {
  const PromoContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => PromoDetail());
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        height: 150,
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
              flex: 2,
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
    return Container(
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
          Text(
            "Promo",
            style: TextStyle(
              color: softOrangeColor,
              fontSize: 14,
            ),
          ),
          Text(
            "BELIPERTAMA",
            style: TextStyle(
              color: choclateColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "Dapatkan diskon 10% untuk pembelian pertama anda di Kampoeng Roti",
            style: TextStyle(
              // color: softOrangeColor,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Icon(
                Icons.access_time,
                size: 35,
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
                    "12 Jan 2019",
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
          padding: EdgeInsets.all(10),
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
              Text(
                "x1",
                style: TextStyle(
                  // color: softOrangeColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

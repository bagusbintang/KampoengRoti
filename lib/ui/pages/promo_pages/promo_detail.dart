import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class PromoDetail extends StatelessWidget {
  const PromoDetail({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          PromoDetailHeader(size: size),
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
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: double.maxFinite,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
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
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 20,
                      ),
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
                                  "PROMOGET",
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
                right: 10,
                bottom: 10,
              ),
              child: Column(
                children: <Widget>[
                  Text(
                    "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nikmati diskon 10% untuk pembelian pertama kamu di kampoeng roti",
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PromoDetailHeader extends StatelessWidget {
  const PromoDetailHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 50,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              margin: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(0),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(0),
                  )),
              child: Text(
                "x1",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/detail_transaction.dart';

import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: softOrangeColor,
      elevation: 0,
      title: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white),
        // padding: EdgeInsets.only(left: 5),
        padding: const EdgeInsets.only(left: 15),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Lokasi Pengiriman',
                      style: TextStyle(color: Colors.grey[500], fontSize: 10),
                    ),
                  ),
                  Container(
                    child: Text(
                      'RUMAH BIMA - Prambanan Residance Surabaya',
                      style: TextStyle(color: Colors.black87, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: ImageIcon(
                AssetImage("assets/images/icon_edit.png"),
                color: Colors.grey,
                size: 20,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Image.asset(
            "assets/images/icon_notif.png",
            height: 25,
            width: 25,
          ),
          onPressed: () {
            // do something
            Get.to(() => DetailTransaction());
          },
        ),
        IconButton(
          icon: Image.asset(
            "assets/images/icon_cart.png",
            height: 25,
            width: 25,
          ),
          onPressed: () {
            Get.to(() => OrderPages());
            // do something
          },
        ),
      ],
    );
  }
}

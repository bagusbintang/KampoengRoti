import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class OrderDoneHeader extends StatelessWidget {
  const OrderDoneHeader({Key key, @required this.size}) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 3,
      width: size.width,
      decoration: BoxDecoration(
          color: softOrangeColor,
          borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(size.width, 150))),
      child: Column(
        children: <Widget>[
          Spacer(),
          Image(
            image: AssetImage(
              "assets/images/order.png",
            ),
            height: 100,
            width: 100,
            color: Colors.white,
          ),
          Text(
            "Order Berhasil",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Order anda telah tercatat, hubungi kami\napabila membutuhkan bantuan",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12),
          ),
          Spacer(),
        ],
      ),
    );
  }
}

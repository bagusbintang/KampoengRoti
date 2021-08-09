import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class OutletsHeader extends StatelessWidget {
  const OutletsHeader({
    Key key,
    @required this.size,
  }) : super(key: key);

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
          Text(
            "Outlets\nKampoeng Roti",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 20),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Kampoeng Roti doloe berdiri pada tahun 2012 dan\nmemliki lebih dari 17 cabang yang telah tersebar di\nSurabaya, Sidoarjo, Gresik, Madura, dan Malang. Silahkan\nmengunjungi outlet terdekat kami",
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

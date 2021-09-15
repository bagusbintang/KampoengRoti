import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RegisMemberBody extends StatelessWidget {
  const RegisMemberBody({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      decoration: BoxDecoration(
        color: softOrangeColor.withOpacity(0.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                children: <Widget>[
                  // Image(
                  //   image: AssetImage(
                  //     "assets/images/kr_logo.png",
                  //   ),
                  //   height: 150,
                  //   width: 150,
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "Bima Aprianto Siono",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  QrImage(
                    version: 5,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    errorCorrectionLevel: QrErrorCorrectLevel.M,
                    padding: EdgeInsets.all(20),
                    size: 200,
                    data: "https://www.qrcode.com/en/about/version.html",
                  ),
                  expiredAndNumberMember(),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100
                          // topLeft: Radius.circular(5),
                          // topRight: Radius.circular(5),
                          // bottomLeft: Radius.circular(5),
                          // bottomRight: Radius.circular(5),
                          ),
                      color: Colors.white,
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/images/kr_logo.png",
                      ),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget expiredAndNumberMember() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      height: 100,
      color: Colors.transparent,
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
                  child: Column(
                    children: <Widget>[
                      Text(
                        "MASA BERLAKU",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Seumur Hidup",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: double.maxFinite,
              color: Colors.black,
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
                  child: Column(
                    children: <Widget>[
                      Text(
                        "NOMOR MEMBER",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "000378433",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

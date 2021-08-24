import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_register_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class UnregisterMemberBody extends StatelessWidget {
  const UnregisterMemberBody({
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
          SizedBox(
            height: 50,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
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
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Anda Belum Terdaftar Sebagai Member",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    child: Text(
                      "Segera daftarkan diri anda sebagai member Kampoeng Roti dan dapatkan berbagai macam keuntungannya",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          memberOffer(),
          Spacer(),
          memberRegisButton(),
          SizedBox(
            height: 10,
          ),
          Text(
            "*BIAYA 50.000 / SELAMANYA",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  Widget memberOffer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(
                  "assets/images/ic_checked_mark.png",
                ),
                height: 50,
                width: 50,
                // color: Colors.white,
              ),
              Text(
                "POTONGAN DISKON 10%",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(
                  "assets/images/ic_checked_mark.png",
                ),
                height: 50,
                width: 50,
                // color: Colors.white,
              ),
              Text(
                "PROMO SPECIAL KHUSUS MEMBER",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: Column(
            children: <Widget>[
              Image(
                image: AssetImage(
                  "assets/images/ic_checked_mark.png",
                ),
                height: 50,
                width: 50,
                // color: Colors.white,
              ),
              Text(
                "INFO PRODUK TERBARU",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget memberRegisButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      height: 80,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: choclateColor,
        onPressed: () {
          Get.to(() => MemberRegister());
        },
        child: Text(
          "DAFTAR SEKARANG",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

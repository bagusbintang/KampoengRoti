import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class ConfirmRegisterMember extends StatelessWidget {
  const ConfirmRegisterMember({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      height: size.height,
      decoration: BoxDecoration(
        color: softOrangeColor.withOpacity(0.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          confirmPaymentButton(),
          SizedBox(
            height: 50,
          ),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Anda telah mendaftar Member",
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
              "Member aktif 1x24 jam setelah pembayaran dilakukan\nApabila ada kendala bisa hubungi kami",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          memberOffer(),
          Spacer(),
        ],
      ),
    );
  }

  Widget confirmPaymentButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35),
      width: double.infinity,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: choclateColor,
        onPressed: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Status Member",
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
            Text(
              "Menunggu Pembayaran",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w900),
            ),
          ],
        ),
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
}

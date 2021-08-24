import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/mini_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountShareApps extends StatelessWidget {
  const AccountShareApps({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            image: DecorationImage(
                image: AssetImage("assets/images/kr_background.png"),
                fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: size.height / 10,
                width: size.width,
                decoration: BoxDecoration(
                    color: softOrangeColor,
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(size.width, 80))),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: AssetImage(
                          "assets/images/kr_logo.png",
                        ),
                        height: 150,
                        width: 150,
                      ),
                      Text(
                        "Bagi Aplikasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bagikan aplikasi ini untuk temanmu dan dapatkan\npromo-promo special",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              QrImage(
                version: 5,
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
                errorCorrectionLevel: QrErrorCorrectLevel.M,
                padding: EdgeInsets.all(20),
                size: 250,
                data: "https://www.qrcode.com/en/about/version.html",
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Bagi Aplikasi Lewat Lainnya",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MiniButton(
                text: "Whatsapp",
                onpress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/contact_us_header.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/mini_button.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountShareApps extends StatelessWidget {
  const AccountShareApps({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void launchWhatsApp({
      @required int phone,
      @required String message,
    }) async {
      String url() {
        if (Platform.isAndroid) {
          // add the [https]
          return "https://wa.me/$phone/?text=${Uri.parse(message)}"; // new line
        } else {
          // add the [https]
          return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(message)}"; // new line
        }
      }

      if (await canLaunch(url())) {
        await launch(url());
      } else {
        throw 'Could not launch ${url()}';
      }
    }

    return Scaffold(
      body: Container(
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/images/kr_background.png"),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   height: size.height / 10,
              //   width: size.width,
              //   decoration: BoxDecoration(
              //       color: softOrangeColor,
              //       borderRadius: BorderRadius.vertical(
              //           bottom: Radius.elliptical(size.width, 80))),
              // ),
              Container(
                height: size.height / 2.4,
                width: size.width,
                child: Stack(
                  children: <Widget>[
                    ContactUsHeader(size: size),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: softOrangeColor,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white,
                          ),
                          child: Image(
                            image: AssetImage(
                              "assets/images/kr_logo.png",
                            ),
                            height: 150,
                            width: 150,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Aplikasi",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: choclateColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Scan QR Code dibawah ini untuk membagikan aplikasi Kampoeng Roti",
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
                data: "http://kampoengroti.com/home",
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
                onpress: () {
                  launchWhatsApp(phone: 628983898855, message: 'Hello');
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

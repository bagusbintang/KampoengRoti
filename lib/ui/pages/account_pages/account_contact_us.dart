import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/contact_us_header.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/mini_button.dart';

class AccountContactUs extends StatelessWidget {
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
              ContactUsHeader(size: size),
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
                        "Hubungi Kami",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Hubungi kami untuk mengetahui informasi lebih lanjut mengenai product atau layanan kami",
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
              MiniButton(
                text: "Whatsapp",
                onpress: () {},
              ),
              MiniButton(
                text: "Telp",
                onpress: () {},
              ),
              MiniButton(
                text: "Email",
                onpress: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

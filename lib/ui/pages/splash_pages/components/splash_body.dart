import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class SplashBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/kr_background.png"),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Image(
                  image: AssetImage(
                    "assets/images/kr_logo.png",
                  ),
                  height: 200,
                  width: 200,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Selamat Datang di\nKampoeng Roti",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Kampoeng Roti menyediakan berbagai macam jenis roti dengan varian rasa dan harga yang sangat terjangkau.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                DefaultButton(
                  text: "MASUK",
                  press: () {
                    Get.to(() => LoginPage());
                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return LoginPage();
                    //   }),
                    // );
                  },
                ),
                // SizedBox(
                //   height: 20,
                // ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

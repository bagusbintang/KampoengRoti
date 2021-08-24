import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class ForgetPassword extends StatefulWidget {
  // const ForgetPassword({ Key? key }) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text("Reset Password"),
          backgroundColor: softOrangeColor,
          elevation: 0,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/images/kr_background.png"),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage(
                    "assets/images/kr_logo.png",
                  ),
                  height: 200,
                  width: 200,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sudah memiliki account?',
                    style: TextStyle(
                      color: choclateColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Masuk disini',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w600,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => LoginPage());
                          },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Masukkan alamat email atau username untuk mereset password anda",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                textFieldEmailOrUsername("Email atau Username"),
                SizedBox(
                  height: 30,
                ),
                DefaultButton(
                  text: "RESET PASSWORD",
                  press: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Theme textFieldEmailOrUsername(String text) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        // controller: emailController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(25),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: text,
            // prefixIcon: icon,
            fillColor: Colors.grey[400]),
      ),
    );
  }
}

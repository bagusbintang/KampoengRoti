import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/register_pages/register_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;

  Icon _iconPwd = Icon(Icons.remove_red_eye_outlined);
  String _password;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      if (_obscureText) {
        _iconPwd = Icon(Icons.remove_red_eye);
      } else {
        _iconPwd = Icon(Icons.remove_red_eye_outlined);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text("Halaman Login"),
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
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
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
                    Text(
                      "Selamat Datang di\nKampoeng Roti",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 26,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textFieldUsername("Username", Icon(Icons.person)),
                    SizedBox(
                      height: 20,
                    ),
                    textFieldPassword("Password", Icon(Icons.lock)),
                    SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      text: "MASUK",
                      press: () {
                        Get.offAll(() => MainPages());
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Belum Punya Akun Kampoeng Roti?",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        FlatButton(
                          child: Text(
                            "Daftar Akun",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: choclateColor,
                                fontWeight: FontWeight.w600),
                          ),
                          onPressed: () {
                            Get.to(() => RegisterPages());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Theme textFieldUsername(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
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
            prefixIcon: icon,
            fillColor: Colors.grey[400]),
      ),
    );
  }

  Theme textFieldPassword(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
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
            prefixIcon: icon,
            suffixIcon: IconButton(
              icon: _iconPwd,
              onPressed: _toggle,
            ),
            fillColor: Colors.grey[400]),
        validator: (val) => val.length < 6 ? 'Password too short.' : null,
        onSaved: (val) => _password = val,
        obscureText: _obscureText,
      ),
    );
  }
}

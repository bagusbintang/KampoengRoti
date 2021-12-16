import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/pages/register_pages/register_member_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

class RegisterPages extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  bool _obscureText = true;
  bool _checkBoxValue = false;

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

  void _checkBoxOnChange() {}

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      if (await authProvider.register(
        username: usernameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
      )) {
        // Get.to(() => RegisterMember());
        Get.to(RegisterMember(
          user: authProvider.user,
        ));
      } else {
        Get.snackbar(
          "Gagal Register",
          "User atau email sudah ada / kosong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: softOrangeColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        );
      }
    }

    return Scaffold(
      backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          centerTitle: true,
          title: Text("Buat Akun"),
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
        child: SingleChildScrollView(
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
                  SizedBox(
                    height: 20,
                  ),
                  textFieldUsername(
                      "Username",
                      Icon(
                        Icons.person,
                        color: Colors.grey[600],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldEmail(
                      "Email",
                      Icon(
                        Icons.mail,
                        color: Colors.grey[600],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldPhone(
                      "Telpon",
                      Icon(
                        Icons.phone_android,
                        color: Colors.grey[600],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  textFieldPassword(
                      "Password",
                      Icon(
                        Icons.lock,
                        color: Colors.grey[600],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultButton(
                    text: "DAFTAR AKUN",
                    press: () {
                      handleSignUp();
                      // Get.to(() => RegisterMember());
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: _checkBoxValue,
                            activeColor: choclateColor,
                            onChanged: (bool newValue) {
                              setState(() {
                                _checkBoxValue = newValue;
                              });
                            },
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Saya Setuju Dengan',
                              style: TextStyle(
                                color: choclateColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Syarat &\nKetentuan',
                                  style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                ),
                                TextSpan(text: ' Kampoeng Roti'),
                              ],
                            ),
                          ),
                          // Text(
                          //   'Saya Setuju Dengan Terms dan\nCondition Kampoeng Roti',
                          //   style: TextStyle(
                          //     color: choclateColor,
                          //     fontWeight: FontWeight.w600,
                          //     fontSize: 14,
                          //   ),
                          //   textAlign: TextAlign.start,
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Sudah Punya Akun Kampoeng Roti?",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          FlatButton(
                            child: Text(
                              "Masuk Akun",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: choclateColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              // Get.to(() => LoginPage());
                              Get.to(LoginPage());
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
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
        controller: usernameController,
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

  Theme textFieldEmail(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
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

  Theme textFieldPhone(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: phoneController,
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
        controller: passwordController,
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

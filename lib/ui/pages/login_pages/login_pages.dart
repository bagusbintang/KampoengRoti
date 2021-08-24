import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/forget_password.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/register_pages/register_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
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

    handleSignIn() async {
      if (await authProvider.login(
        // username: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Get.offAll(() => MainPages());
      } else {
        Get.snackbar(
          "Gagal Login",
          "Username atau Password salah / kosong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: softOrangeColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        );
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     backgroundColor: choclateColor,
        //     content: Text(
        //       'Gagal Login!',
        //       textAlign: TextAlign.center,
        //     ),
        //   ),
        // );
      }
    }

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
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: CheckboxListTile(
                            title: Text(
                              "Ingat Saya",
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            value: _checkBoxValue,
                            activeColor: Colors.grey[600],
                            onChanged: (bool newValue) {
                              setState(() {
                                _checkBoxValue = newValue;
                              });
                            },
                            controlAffinity: ListTileControlAffinity
                                .leading, //  <-- leading Checkbox
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: FlatButton(
                            child: Text(
                              "Lupa Password?",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: choclateColor,
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => ForgetPassword());
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  DefaultButton(
                    text: "MASUK",
                    press: () {
                      handleSignIn();
                      // Get.offAll(() => MainPages());
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
                  // Spacer(),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/unregister_member_body.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_page.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_register_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class RegisterMember extends StatefulWidget {
  const RegisterMember({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  _RegisterMemberState createState() => _RegisterMemberState();
}

class _RegisterMemberState extends State<RegisterMember> {
  TextEditingController numberController = TextEditingController(text: '');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                Spacer(),
                Text(
                  "Sudah Jadi Member?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: choclateColor,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Masukkan nomer member anda di kolom bawah.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                textFieldNomerMember("Nomer Member Kampoeng Roti"),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // width: double.infinity,
                  width: 150,
                  height: 50,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: choclateColor,
                    onPressed: () {
                      if (numberController.text.isEmpty ||
                          numberController.text == '') {
                        Get.snackbar(
                          "Nomor member tidak boleh kosong",
                          "",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: softOrangeColor,
                          margin: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                        );
                      } else {
                        Get.to(LoginPage());
                      }
                    },
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Belum jadi Member?\nDaftarkan dirimu sekarang untuk dapat menikmati promo khusus Member Kampoeng Roti",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DefaultButton(
                  text: "DAFTAR MEMBER",
                  press: () {
                    Get.off(MemberRegister(
                      user: widget.user,
                    ));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                DefaultButton(
                  text: "LEWATI",
                  press: () {
                    Get.to(LoginPage());
                  },
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Theme textFieldNomerMember(String text) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        controller: numberController,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(25),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[500]),
            hintText: text,
            // prefixIcon: icon,
            fillColor: Colors.grey[300]),
      ),
    );
  }
}

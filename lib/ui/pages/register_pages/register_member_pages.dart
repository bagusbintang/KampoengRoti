import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class RegisterMember extends StatefulWidget {
  // const RegisterMember({ Key? key }) : super(key: key);

  @override
  _RegisterMemberState createState() => _RegisterMemberState();
}

class _RegisterMemberState extends State<RegisterMember> {
  @override
  Widget build(BuildContext context) {
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
                      Get.to(LoginPage());
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
                    Get.to(LoginPage());
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
            hintStyle: new TextStyle(color: Colors.grey[500]),
            hintText: text,
            // prefixIcon: icon,
            fillColor: Colors.grey[300]),
      ),
    );
  }
}

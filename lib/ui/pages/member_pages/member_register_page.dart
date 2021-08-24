import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/confirm_payment_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class MemberRegister extends StatelessWidget {
  const MemberRegister({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DAFTAR",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/kr_background2.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              height: size.height,
              decoration: BoxDecoration(
                color: softOrangeColor.withOpacity(0.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                        bottomRight: Radius.circular(5),
                      ),
                      color: Colors.white,
                    ),
                    child: Image(
                      image: AssetImage(
                        "assets/images/kr_logo.png",
                      ),
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Member\nKampoeng Roti",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "*BIAYA 50.000 / SELAMANYA",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldPersonName(
                    "Nama Lengkap",
                    Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldAddress(
                    "Alamat",
                    Icon(Icons.mail),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldBirthDate(
                    "Tanggal Lahir",
                    Icon(Icons.calendar_today),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldNumberId(
                    "Nomer Identitas (KTP/SIM)",
                    Icon(Icons.card_travel),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  uploadPhotoButton(),
                  Spacer(),
                  regisButton(),
                  Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Theme textFieldPersonName(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.name,
        // controller: usernameController,
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
            fillColor: Colors.white),
      ),
    );
  }

  Theme textFieldAddress(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
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
            prefixIcon: icon,
            fillColor: Colors.white),
      ),
    );
  }

  Theme textFieldBirthDate(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        // controller: phoneController,
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
            fillColor: Colors.white),
      ),
    );
  }

  Theme textFieldNumberId(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        // controller: phoneController,
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
            fillColor: Colors.white),
      ),
    );
  }

  Container uploadPhotoButton() {
    return Container(
      width: double.infinity,
      height: 70,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey,
        onPressed: () {},
        child: Text(
          "+UPLOAD IDENTITAS (KTP/SIM)",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  Container regisButton() {
    return Container(
      width: double.infinity,
      height: 70,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: choclateColor,
        onPressed: () {
          Get.to(() => ConfirmPayment());
        },
        child: Text(
          "DAFTAR SEKARANG",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/confirm_payment_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';

class MemberRegister extends StatefulWidget {
  const MemberRegister({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  State<MemberRegister> createState() => _MemberRegisterState();
}

class _MemberRegisterState extends State<MemberRegister> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController numberController = TextEditingController(text: '');
  TextEditingController dateController = TextEditingController(text: '');
  DateTime datenow = DateTime.now();
  var formatDate = DateFormat('d MMMM yyyy');
  File _image;
  ProgressDialog pr;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);

    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: softOrangeColor, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    handleRegistMember() async {
      formatDate = DateFormat('yyyy-MM-dd');
      pr.show();
      if (await authProvider.registMember(
        userId: widget.user.id,
        address: addressController.text,
        birthdate: formatDate.format(datenow),
        noKtp: numberController.text,
        imageFile: _image,
      )) {
        // Get.to(() => RegisterMember());
        // Get.to(RegisterMember(
        //   user: authProvider.user,
        // ));
        pr.hide();
        Get.off(ConfirmPayment()).then((_) => Get.snackbar(
              "Register Member Berhasil!!",
              "",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: softOrangeColor,
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            ));
      } else {
        pr.hide();
        Get.snackbar(
          "Gagal Register Member",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: softOrangeColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        );
      }
    }

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
                    widget.user.defaulAdress != null
                        ? widget.user.defaulAdress.address
                        : "",
                    Icon(Icons.mail),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  textFieldBirthDate(
                    datenow == null
                        ? "Tanggal Lahir"
                        : formatDate.format(datenow),
                    Icon(Icons.calendar_today),
                    context,
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
                  _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.file(
                            _image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : uploadPhotoButton(context),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 70,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: choclateColor,
                      onPressed: handleRegistMember,
                      child: Text(
                        "DAFTAR SEKARANG",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
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
        controller: nameController,
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
        controller: addressController,
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

  Theme textFieldBirthDate(String text, Icon icon, BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: InkWell(
        onTap: () {
          DatePicker.showDatePicker(context,
              showTitleActions: true,
              minTime: DateTime(1970, 12, 31),
              maxTime: DateTime(2005, 12, 31),
              theme: DatePickerTheme(
                  headerColor: softOrangeColor,
                  backgroundColor: Colors.white,
                  itemStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  doneStyle: TextStyle(color: Colors.black, fontSize: 16)),
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            print('confirm $date');
            setState(() {
              datenow = date;
            });
          }, currentTime: datenow, locale: LocaleType.id);
        },
        child: TextFormField(
          enabled: false, // controller: phoneController,
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
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: text,
            prefixIcon: icon,
            fillColor: Colors.white),
      ),
    );
  }

  Container uploadPhotoButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey,
        onPressed: () {
          _showPicker(context);
        },
        child: Text(
          "+UPLOAD IDENTITAS (KTP/SIM)",
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }

  // Container regisButton() {
  //   return Container(
  //     width: double.infinity,
  //     height: 70,
  //     child: FlatButton(
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  //       color: choclateColor,
  //       onPressed: (){},
  //       child: Text(
  //         "DAFTAR SEKARANG",
  //         style: TextStyle(
  //             fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
  //       ),
  //     ),
  //   );
  // }
}

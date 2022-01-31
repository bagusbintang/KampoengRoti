import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController personNameController;
  TextEditingController emailController;
  TextEditingController phoneController;

  UserModel userModel = Get.arguments;
  UserSingleton userSingleton = UserSingleton();

  @override
  void dispose() {
    super.dispose();
    personNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    personNameController = TextEditingController(text: userModel.name);
    emailController = TextEditingController(text: userModel.email);
    phoneController = TextEditingController(
        text: userModel.phone != null ? userModel.phone.toString() : "0");

    handleUpdateProile() async {
      if (await authProvider.updateProfile(
          userId: userModel.id,
          name: personNameController.text,
          email: emailController.text,
          phone: phoneController.text)) {
        userModel.name = personNameController.text;
        userModel.email = emailController.text;
        userModel.phone = phoneController.text;

        MySharedPreferences.instance.setUserModel("user", userModel);
        userSingleton.user = userModel;
        Get.back();
      } else {
        Get.snackbar(
          "Gagal Ubah Profil",
          "",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: softOrangeColor,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ubah Profil",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              textFieldPersonName(
                "Nama Pengguna",
              ),
              textFieldEmail(
                "Alamat Email",
              ),
              textFieldPersonPhone(
                "Nomor Telpon",
              ),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: "SIMPAN",
                press: () {
                  handleUpdateProile();
                  // Get.back();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container textFieldPersonName(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              controller: personNameController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldEmail(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldPersonPhone(String title, {int initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }
}

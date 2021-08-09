import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profil",
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
                "Nama Penerima",
                initValue: "Bima Aprianto Siono",
              ),
              textFieldAddress(
                "Alamat",
                initValue: "bima.aprianto@gmail.com",
              ),
              textFieldPersonPhone(
                "Nomor Telpon",
                initValue: 081805512618,
              ),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: "SIMPAN",
                press: () {
                  Get.back();
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
              initialValue: initValue,
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

  Container textFieldAddress(String title, {String initValue}) {
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
              initialValue: initValue,
              keyboardType: TextInputType.name,
              maxLines: 3,
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
              initialValue: initValue.toString(),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/add_address.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/components/user_address_list.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

import '../../../shared_preferences.dart';

class DeliveryAddress extends StatefulWidget {
  @override
  _DeliveryAddressState createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  UserModel userModel;

  void getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Alamat",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[350],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            UserAddressList(userModel: userModel),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultButton(
                text: "+TAMBAH ALAMAT BARU",
                press: () {
                  Get.to(
                    AddAddress(),
                    arguments: userModel,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Theme textFieldSearchOutlets(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey[400],
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[400]),
            hintText: text,
            suffixIcon: icon,
            fillColor: Colors.transparent),
      ),
    );
  }
}

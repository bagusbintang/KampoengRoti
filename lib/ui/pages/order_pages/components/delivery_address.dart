import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/address_container.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class DeliveryAddress extends StatelessWidget {
  List<AccountAddress> addressList = [
    AccountAddress(
      "Kantor",
      "Bima Aprianto Siono",
      "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213",
      081081808103,
      true,
    ),
    AccountAddress(
      "Rumah Prambanan",
      "Bima Aprianto Siono",
      "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213",
      081011122134,
      false,
    ),
    AccountAddress(
      "Rumah Lily",
      "Tjio Lily Indrawati",
      "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213",
      081088808123,
      false,
    ),
  ];
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
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: textFieldSearchOutlets("Cari Outlets", Icon(Icons.search)),
            ),
            SizedBox(
              height: 15,
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Container(
              child: Column(
                children: List.generate(
                  addressList.length,
                  (index) => AddressContainer(
                    addressName: addressList[index].addressName,
                    personName: addressList[index].personName,
                    personAddres: addressList[index].personAddres,
                    personPhone: addressList[index].personPhone,
                    mainAddress: addressList[index].mainAddress,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: DefaultButton(
                text: "+TAMBAH ALAMAT BARU",
                press: () {},
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

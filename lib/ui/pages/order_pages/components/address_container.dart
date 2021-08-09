import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/address_person.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class AccountAddress {
  String addressName;
  String personName;
  String personAddres;
  int personPhone;
  bool mainAddress;

  AccountAddress(
    this.addressName,
    this.personName,
    this.personAddres,
    this.personPhone,
    this.mainAddress,
  );
}

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    Key key,
    this.addressName,
    this.personName,
    this.personAddres,
    this.personPhone,
    this.mainAddress,
  }) : super(key: key);
  final String addressName;
  final String personName;
  final String personAddres;
  final int personPhone;
  final bool mainAddress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    addressName.toUpperCase(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: softOrangeColor,
                    ),
                  ),
                  Visibility(
                    visible: mainAddress,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.done,
                              size: 12,
                              color: softOrangeColor,
                            ),
                          ),
                          TextSpan(
                            text: "Alamat Utama",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: softOrangeColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              personName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              personAddres,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.clip,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No. Telpon : ${personPhone}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => AddressPerson(), arguments: [
                        addressName,
                        personName,
                        personAddres,
                        personPhone,
                      ]);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            "edit",
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: softOrangeColor,
                            ),
                          ),
                          ImageIcon(
                            AssetImage(
                              "assets/images/icon_writing.png",
                            ),
                            color: softOrangeColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}

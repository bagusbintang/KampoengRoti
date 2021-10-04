import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/edit_address.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class AddressContainer extends StatelessWidget {
  const AddressContainer({
    Key key,
    this.userAddres,
    this.press,
  }) : super(key: key);
  final UserAddressModel userAddres;
  final Function press;

  @override
  Widget build(BuildContext context) {
    bool mainAddress = false;
    if (userAddres.defaultAddress == 0) {
      mainAddress = false;
    } else {
      mainAddress = true;
    }
    return InkWell(
      onTap: press,
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
                    userAddres.tagAddress.toUpperCase(),
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
              userAddres.personName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              userAddres.address,
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
                    "No. Telpon : ${userAddres.personPhone}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        EditAddress(),
                        arguments: userAddres,
                      );
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

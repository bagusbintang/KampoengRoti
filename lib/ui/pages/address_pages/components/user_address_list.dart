import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/user_address_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/edit_address.dart';
import 'package:provider/provider.dart';

import '../address_container.dart';

class UserAddressList extends StatelessWidget {
  const UserAddressList({
    Key key,
    @required this.userModel,
  }) : super(key: key);

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    UserAddressProvider addressProvider =
        Provider.of<UserAddressProvider>(context);
    return userModel != null
        ? Container(
            child: FutureBuilder(
              future: addressProvider.getUserAddress(userId: userModel.id),
              builder: (context, snapshot) {
                return Column(
                  children: addressProvider.userAddress
                      .map((address) => AddressContainer(
                            userAddres: address,
                            press: () {
                              Get.back(result: address);
                              // Get.to(
                              //   EditAddress(),
                              //   arguments: address,
                              // );
                            },
                          ))
                      .toList(),
                );
              },
            ),
          )
        : Container();
  }
}

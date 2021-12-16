import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../../shared_preferences.dart';

class MainAppBar extends StatefulWidget {
  const MainAppBar({
    Key key,
  }) : super(key: key);

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> with WidgetsBindingObserver {
  CartProvider cartProvider;
  UserModel userModel;

  Future<void> getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    // userSingleton.address = userModel.defaulAdress;
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // getUserModel();
  }

  // Future<void> getCartList() async {
  //   // cartProvider = Provider.of<CartProvider>(context);
  //   // userModel = await MySharedPreferences.instance.getUserModel("user");
  //   await cartProvider.getCart(userId: userModel.id);
  //   // setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    UserSingleton userSingleton = UserSingleton();
    if (userSingleton.address == null) {
      userSingleton.address = userModel.defaulAdress;
    }
    return AppBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      backgroundColor: softOrangeColor,
      elevation: 0,
      title: InkWell(
        onTap: () async {
          Get.to(DeliveryAddress()).then((value) => setState(() {
                if (value != null) {
                  userSingleton.address = value;
                  userSingleton.outlet = userSingleton.address.outletModel;
                }
              }));
          // var result = await Get.to(DeliveryAddress());

          // setState(() {
          //   if (result != null) {
          //     userSingleton.address = result;
          //     userSingleton.outlet = userSingleton.address.outletModel;
          //   }
          // });
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          // padding: EdgeInsets.only(left: 5),
          padding: const EdgeInsets.only(left: 15),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        'Lokasi Pengiriman',
                        style: TextStyle(color: Colors.grey[500], fontSize: 10),
                      ),
                    ),
                    Container(
                      child: Text(
                        userSingleton.address != null
                            ? userSingleton.address.tagAddress.toUpperCase() +
                                " - " +
                                userSingleton.address.address
                            : 'Alamat utama belum ditentukan. ',
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: ImageIcon(
                  AssetImage("assets/images/icon_edit.png"),
                  color: Colors.grey,
                  size: 20,
                ),
                onPressed: null,
                // () async {
                //   // Get.to(DeliveryAddress());
                //   var result = await Get.to(DeliveryAddress());
                //   setState(() {
                //     if (result != null) {
                //       userSingleton.address = result;
                //       userSingleton.outlet =
                //           userSingleton.address.outletModel;
                //     }
                //   });
                // },
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: IconButton(
            icon: Image.asset(
              "assets/images/icon_notif.png",
              height: 25,
              width: 25,
            ),
            onPressed: () {
              // do something
              // Get.to(() => DetailTransaction());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Stack(
            children: <Widget>[
              IconButton(
                icon:
                    // Align(
                    //   alignment: Alignment.bottomCenter,
                    //   child: Icon(Icons.shopping_cart_rounded,
                    //       color: Colors.black, size: 25),
                    // ),
                    // onPressed: () {
                    //   Get.to(() => OrderPages());
                    // },
                    Image.asset(
                  "assets/images/icon_cart.png",
                  height: 27,
                  width: 27,
                ),
                onPressed: () {
                  Get.to(OrderPages()).then((value) => setState(() {}));
                  // do something
                },
              ),
              Positioned(
                right: 3,
                // left: 0,
                top: 3,
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    color: softOrangeColor,
                  ),
                  // child: Consumer<CartProvider>(
                  //   builder: (context, value, child) => Text(
                  //     value.totalCart().toString(),
                  //     style: TextStyle(
                  //       fontSize: 8,
                  //     ),
                  //   ),
                  // ),
                  child: FutureBuilder(
                    future: cartProvider.getCart(userId: userSingleton.user.id),
                    builder: (context, snapshot) => Text(
                      cartProvider.totalCart().toString(),
                      style: TextStyle(
                        fontSize: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

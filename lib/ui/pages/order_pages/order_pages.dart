import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/item_order.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_detail.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

class OrderPages extends StatefulWidget {
  @override
  _OrderPagesState createState() => _OrderPagesState();
}

class _OrderPagesState extends State<OrderPages> with WidgetsBindingObserver {
  CartProvider cartProvider;
  UserModel userModel;

  Future<void> getCartList() async {
    // cartProvider = Provider.of<CartProvider>(context);
    userModel = await MySharedPreferences.instance.getUserModel("user");
    await cartProvider.getCart(userId: userModel.id);
    // setState(() {});
  }

  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   getCartList();
  // }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState
  //   getCartList();
  // }
  // @override
  // void dispose() {
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    final currencyFormatter = NumberFormat('#,###', 'ID');
    cartProvider = Provider.of<CartProvider>(context);
    final MainPageController mainPageController =
        Get.put(MainPageController(), permanent: true);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shopping Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: getCartList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return (cartProvider.carts.length > 0)
              ? SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Ringkasan Pesanan",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            TextButton(
                              child: Text("+ Tambah"),
                              style: TextButton.styleFrom(
                                primary: softOrangeColor,
                                textStyle: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 20,
                        thickness: 1,
                      ),
                      FutureBuilder(
                        future: getCartList(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          return Container(
                            child: Column(
                              children: cartProvider.carts
                                  .map((cart) => ItemOrder(
                                        cart: cart,
                                      ))
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      // Container(
                      //   child: Column(
                      //     children: cartProvider.carts
                      //         .map((cart) => ItemOrder(
                      //               cart: cart,
                      //             ))
                      //         .toList(),
                      //   ),
                      // ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Sub-Total",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "Rp ${currencyFormatter.format(cartProvider.totalPrice())}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: softOrangeColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // DeliveryWay(),
                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        color: Colors.white,
                        child: Column(
                          children: <Widget>[
                            DefaultButton(
                              text: "LANJUTKAN",
                              press: () {
                                Get.off(OrderDetail());
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Dengan menekan tombol diatas, saya menyetujui untuk\nsyarat dan ketentuan yang berlaku",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        Image(
                          image: AssetImage(
                            "assets/images/ic_empty_cart.png",
                          ),
                          height: 80,
                          width: 80,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Keranjang belanjamu kosong",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "BELANJA SEKARANG",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        DefaultButton(
                          text: "MULAI BELANJA",
                          press: () {
                            Get.back();
                            mainPageController.changeTabIndex(1);
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    );
  }
}

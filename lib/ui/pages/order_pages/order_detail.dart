import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/models/promo_model.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/order_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/outlet_home_page.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_page.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/address_info.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_choose_button.dart';
// import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_way.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/item_order_detail.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_done.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_detail.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

class Payment {
  String payment;

  Payment(this.payment);
}

class OrderDetail extends StatefulWidget {
  const OrderDetail({
    Key key,
  }) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  Payment selectedPayment;
  UserSingleton userSingleton = UserSingleton();
  List<Payment> paymentList = [
    Payment("COD"),
  ];
  List<DropdownMenuItem> generateItems(List<Payment> paymentList) {
    List<DropdownMenuItem> items = [];
    for (var item in paymentList) {
      items.add(
        DropdownMenuItem(
          child: Text(item.payment, textAlign: TextAlign.center),
          value: item,
        ),
      );
    }
    return items;
  }

  // UserModel userModel;
  // void getUserModel() async {
  //   userModel = await MySharedPreferences.instance.getUserModel("user");
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserModel();
  // }

  String selectedOutlet = "Pilih Outlet";
  String selectedPromo = "Tambah Promo";
  int delivPayment = 0;
  double promoDisc = 0;
  double memberDisc = 0;
  double totalDisc = 0;

  UserAddressModel userAddress;
  OutletModel outletModel;
  PromoModel promo;
  bool isDeliveryChoosen = true;
  bool isPickUpChoosen = false;
  bool isValueNotGetMinDisc = false;
  DateTime datenow = DateTime.now();
  var formatDate = DateFormat('d MMMM yyyy');
  // var formatTime = DateFormat.Hm().format(date);

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    if (userSingleton.outlet != null) {
      selectedOutlet = userSingleton.outlet.title +
          "( ${userSingleton.outlet.distance.round()} KM )";

      if (userSingleton.outlet.distance.round() > 5) {
        int range = userSingleton.outlet.distance.round() - 5;
        delivPayment = 2000 * range + 5000;
      } else {
        delivPayment = 5000;
      }
    }

    if (userSingleton.user.memberNo != null) {
      totalDisc = 0;
      memberDisc = 0;
      setState(() {
        memberDisc = userSingleton.user.discMember;
        if (memberDisc >= 100) {
          totalDisc += memberDisc;
        } else {
          memberDisc = (memberDisc / 100) * cartProvider.totalPrice();
          // if (memberDisc > promo.maxDisc) {
          //   memberDisc = promo.maxDisc;
          // }
          totalDisc += promoDisc;
        }
      });
    }

    handleCheckOut() async {
      if (isDeliveryChoosen) {
        if (await orderProvider.checkOut(
          userId: userSingleton.user.id,
          deliveryMethod: 1,
          addressId:
              userAddress != null ? userAddress.id : userSingleton.address.id,
          outletId: userSingleton.outlet != null ? userSingleton.outlet.id : 1,
          promoId: promo != null ? promo.id : 0,
          shippingCosts: delivPayment.toDouble(),
          promoDisc: promo != null ? promo.discount : 0,
          memberDisc: userSingleton.user.memberNo != null
              ? userSingleton.user.discMember
              : 0,
          deliveryTime: datenow.toString(),
          paymenMethod: selectedPayment.payment,
          note: "",
          total: cartProvider.totalPrice(),
          grandTotal: cartProvider.totalPrice(),
        )) {
          Get.off(OrderDone(), arguments: [datenow, isDeliveryChoosen]);
        } else {
          Get.snackbar(
            "Gagal CheckOut",
            "Ada yang salah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: softOrangeColor,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          );
        }
      } else {
        if (await orderProvider.checkOut(
          userId: userSingleton.user.id,
          deliveryMethod: 2,
          outletId: userSingleton.outlet != null ? userSingleton.outlet.id : 1,
          promoId: promo != null ? promo.id : 0,
          shippingCosts: 0,
          promoDisc: promo != null ? promo.discount : 0,
          memberDisc: userSingleton.user.memberNo != null
              ? userSingleton.user.discMember
              : 0,
          deliveryTime: datenow.toString(),
          paymenMethod: selectedPayment.payment,
          note: "",
          total: cartProvider.totalPrice(),
          grandTotal: cartProvider.totalPrice(),
        )) {
          Get.off(OrderDone(), arguments: [
            datenow,
            isDeliveryChoosen,
          ]);
        } else {
          Get.snackbar(
            "Gagal CheckOut",
            "Ada yang salah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: softOrangeColor,
            margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          );
        }
      }
    }

    // checkMemberDisc();
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
          onPressed: () => Get.off(OrderPages()),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Ringkasan Pesanan",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    child: Text("Ubah Pesanan"),
                    style: TextButton.styleFrom(
                      primary: softOrangeColor,
                      textStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {
                      Get.off(OrderPages());
                    },
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Container(
              child: Column(
                children: cartProvider.carts
                    .map((cart) => ItemOrderDetail(
                          cart: cart,
                        ))
                    .toList(),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            SizedBox(
              width: 20,
            ),
            deliveryMethod(currencyFormatter, cartProvider, context),
            // DeliveryWay(),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  DefaultButton(
                    text: "SETUJU & ORDER",
                    press: () {
                      // Get.to(() => OrderDone());
                      handleCheckOut();
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
      ),
    );
  }

  Widget deliveryMethod(NumberFormat currencyFormatter,
      CartProvider cartProvider, BuildContext context) {
    checkMemberDisc() {
      totalDisc = 0;
      memberDisc = 0;
      if (userSingleton.user.memberNo != null) {
        memberDisc = userSingleton.user.discMember;
        if (memberDisc > 100) {
          totalDisc += memberDisc;
        } else {
          memberDisc = (memberDisc / 100) * cartProvider.totalPrice();
          // if (memberDisc > promo.maxDisc) {
          //   memberDisc = promo.maxDisc;
          // }
          totalDisc += promoDisc;
        }
      }
    }

    return Container(
      color: Colors.grey[200],
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CartChooseButton(
                  text: "Delivery",
                  press: () {
                    setState(() {
                      isDeliveryChoosen = true;
                      isPickUpChoosen = false;
                    });
                  },
                  backgroundColor:
                      isDeliveryChoosen ? softOrangeColor : Colors.white,
                  textColor: isDeliveryChoosen ? Colors.white : Colors.black,
                ),
                SizedBox(
                  width: 15,
                ),
                CartChooseButton(
                  text: "Pick Up",
                  press: () {
                    setState(() {
                      isPickUpChoosen = true;
                      isDeliveryChoosen = false;
                    });
                  },
                  backgroundColor:
                      isPickUpChoosen ? softOrangeColor : Colors.white,
                  textColor: isPickUpChoosen ? Colors.white : Colors.black,
                ),
              ],
            ),
          ),
          deliveryInfo(isDeliveryChoosen),
          // DeliveryInfo(isChoosen: isDeliveryChoosen),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Biaya Pengiriman",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  isDeliveryChoosen
                      ? userSingleton.outlet != null
                          ? "Rp ${currencyFormatter.format(delivPayment)}"
                          : "Rp 0"
                      : "Rp 0",
                  style: TextStyle(
                    color: softOrangeColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "Promo",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Visibility(
                      visible: isValueNotGetMinDisc,
                      child: IconButton(
                        icon: Icon(
                          Icons.error_outline_outlined,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          Get.snackbar(
                            null,
                            "Oops.. kamu belum memenuhi minimal pemesanan..",
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: softOrangeColor,
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                          );
                        },
                      ),
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    promo == null
                        ? Get.to(PromoPage(
                            fromPayment: true,
                          )).then((value) => setState(() {
                              // totalDisc = 0;
                              if (value != null) {
                                promo = value;
                                if (cartProvider.totalPrice() >
                                    promo.minTrans) {
                                  print(promo.promoType);
                                  if (promo.promoType == 1) {
                                    if (promo.discount > 100) {
                                      promoDisc = promo.discount;
                                      totalDisc += promoDisc;
                                    } else {
                                      promoDisc = (promo.discount / 100) *
                                          cartProvider.totalPrice();

                                      if (promoDisc > promo.maxDisc) {
                                        promoDisc = promo.maxDisc;
                                      }
                                      totalDisc += promoDisc;
                                    }
                                  } else if (promo.promoType == 2) {
                                    if (promo.discount > 100) {
                                      promoDisc = promo.discount;
                                      totalDisc += promoDisc;
                                    } else {
                                      promoDisc =
                                          (promo.discount / 100) * delivPayment;
                                      if (promoDisc > promo.maxDisc) {
                                        promoDisc = promo.maxDisc;
                                      }
                                      totalDisc += promoDisc;
                                    }
                                  }
                                } else {
                                  isValueNotGetMinDisc = true;
                                }
                              }
                            }))
                        : Get.to(PromoDetail(
                            promo: promo,
                            used: true,
                            fromPaymentPage: true,
                          )).then((value) => setState(() {
                              // totalDisc = 0;
                              promo = value;
                              if (promo == null) {
                                promoDisc = 0;
                                isValueNotGetMinDisc = false;
                                checkMemberDisc();
                                totalDisc += promoDisc;
                              }
                            }));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      promo == null ? selectedPromo : promo.title,
                      style: TextStyle(
                        color: softOrangeColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: <Widget>[
          //       Row(
          //         children: [
          //           Text(
          //             "Member",
          //             style: TextStyle(
          //               fontSize: 12,
          //               fontWeight: FontWeight.w600,
          //             ),
          //           ),
          //           IconButton(
          //             icon: Icon(Icons.error_outline_outlined),
          //             onPressed: () {},
          //           )
          //         ],
          //       ),
          //       InkWell(
          //         onTap: () {
          //           Get.to(MemberPage());
          //         },
          //         child: Text(
          //           "Tambah Member",
          //           style: TextStyle(
          //             color: softOrangeColor,
          //             fontSize: 12,
          //             fontWeight: FontWeight.w500,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Total Pembayaran",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Harga Belanja",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Rp ${currencyFormatter.format(cartProvider.totalPrice())}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: promoDisc > 0 ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Promo",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Rp ${currencyFormatter.format(promoDisc)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: memberDisc > 0 ? true : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Member",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        "Rp ${currencyFormatter.format(memberDisc)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Biaya Pengiriman",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      isDeliveryChoosen
                          ? userSingleton.outlet != null
                              ? "Rp ${currencyFormatter.format(delivPayment)}"
                              : "Rp 0"
                          : "Rp 0",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: 20,
                  thickness: 1,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "TOTAL PAYMENT",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      isDeliveryChoosen
                          ? userSingleton.outlet != null
                              ? "Rp ${currencyFormatter.format(cartProvider.totalPrice() + delivPayment - memberDisc - promoDisc)}"
                              : "Rp ${currencyFormatter.format(cartProvider.totalPrice() - memberDisc - promoDisc)}"
                          : "Rp ${currencyFormatter.format(cartProvider.totalPrice() - memberDisc - promoDisc)}",
                      style: TextStyle(
                        color: softOrangeColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          selectPayment(context),
          // SelectPayment(),
        ],
      ),
    );
  }

  Widget selectPayment(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            "Cara Pembayaran",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: DropdownButton(
                  value: selectedPayment,
                  items: generateItems(paymentList),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  iconEnabledColor: Colors.black,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Pilih Metode Pembayaran",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  onChanged: (item) {
                    setState(() {
                      selectedPayment = item;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  Widget deliveryInfo(bool isChoosen) {
    return Container(
      color: softOrangeColor,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Text(
                isChoosen ? "Delivery".toUpperCase() : "Pick Up".toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            Visibility(
              visible: isChoosen,
              child: InkWell(
                onTap: () async {
                  var result = await Get.to(DeliveryAddress());
                  setState(() {
                    userAddress = result;
                    userSingleton.outlet.distance = calculateDistance(
                        userAddress.latitude,
                        userAddress.longitude,
                        userSingleton.outlet.latitude,
                        userSingleton.outlet.longitude);
                    selectedOutlet = userSingleton.outlet.title +
                        "( ${userSingleton.outlet.distance.round()} KM )";

                    if (userSingleton.outlet.distance.round() > 5) {
                      int range = userSingleton.outlet.distance.round() - 5;
                      delivPayment = 2000 * range + 5000;
                    } else {
                      delivPayment = 5000;
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white),
                  // padding: EdgeInsets.only(left: 5),
                  // padding: const EdgeInsets.only(left: 15),
                  padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Lokasi Pengiriman',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 10),
                              ),
                            ),
                            Container(
                              child: Text(
                                userAddress != null
                                    ? userAddress.tagAddress.toUpperCase() +
                                        " - " +
                                        userAddress.address
                                    : userSingleton.address != null
                                        ? userSingleton.address.tagAddress +
                                            " - " +
                                            userSingleton.address.address
                                        : 'Pilih Alamat',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
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
                        onPressed: () async {
                          var result = await Get.to(DeliveryAddress());
                          setState(() {
                            userAddress = result;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  // InkWell(
                  //   onTap: () async {
                  //     // _getCurrentLocation();
                  //     userSingleton.outlet = await Get.to(OutletHomePage(
                  //         // currentPosition: _currentPosition,
                  //         userModel: userSingleton.user));
                  //     setState(() {
                  //       if (userSingleton.outlet != null) {
                  //         selectedOutlet = userSingleton.outlet.title +
                  //             "( ${userSingleton.outlet.distance.round()} KM )";
                  //       }
                  //     });
                  //   },
                  //   child: AddressInfo(
                  //     titleName: "Outlet Pengiriman",
                  //     bodyName: selectedOutlet,
                  //   ),
                  // ),
                  AddressInfo(
                    titleName:
                        isChoosen ? "Outlet Pengiriman" : "Outlet Pengambilan",
                    bodyName: selectedOutlet,
                    press: null,
                  ),
                  AddressInfo(
                    titleName: isChoosen
                        ? "Tanggal Pengiriman"
                        : "Tanggal Pengambilan",
                    bodyName: formatDate.format(datenow),
                    press: () {
                      DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: datenow,
                          maxTime: DateTime(datenow.year, 12, 31),
                          theme: DatePickerTheme(
                              headerColor: softOrangeColor,
                              backgroundColor: Colors.white,
                              itemStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              doneStyle:
                                  TextStyle(color: Colors.black, fontSize: 16)),
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
                  ),
                  AddressInfo(
                    titleName: isChoosen ? "Jam Pengiriman" : "Jam Pengambilan",
                    bodyName: DateFormat.Hm().format(datenow),
                    press: () {
                      DatePicker.showTime12hPicker(context,
                          showTitleActions: true, onChanged: (date) {
                        print('change $date in time zone ' +
                            date.timeZoneOffset.inHours.toString());
                      }, onConfirm: (date) {
                        print('confirm $date');
                        setState(() {
                          datenow = date;
                        });
                      }, currentTime: datenow);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

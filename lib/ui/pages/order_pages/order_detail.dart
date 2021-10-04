import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/order_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_page.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/address_info.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_choose_button.dart';
// import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_way.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/item_order_detail.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_done.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

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
  List<Payment> paymentList = [
    Payment("COD"),
    Payment("OVO"),
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

  UserAddressModel userAddress;
  bool isDeliveryChoosen = false;
  bool isPickUpChoosen = false;
  DateTime date = DateTime.now();
  var formatDate = DateFormat('d MMMM yyyy');
  // var formatTime = DateFormat.Hm().format(date);

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);

    handleCheckOut() async {
      if (await orderProvider.checkOut(
        userId: userAddress.userId,
        deliveryMethod: isDeliveryChoosen ? 1 : 2,
        addressId: userAddress.id,
        outletId: 1,
        promoId: 1,
        shippingCosts: isDeliveryChoosen ? 10000 : 0,
        promoDisc: 0,
        memberDisc: 0,
        deliveryTime: date.toString(),
        paymenMethod: selectedPayment.payment,
        note: "",
        total: cartProvider.totalPrice(),
        grandTotal: isDeliveryChoosen
            ? cartProvider.totalPrice() + 10000
            : cartProvider.totalPrice(),
      )) {
        Get.off(OrderDone());
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
                    "Rp. ${currencyFormatter.format(cartProvider.totalPrice())}",
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
                  isDeliveryChoosen ? "Rp 10.000" : "Rp 0",
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
                    IconButton(
                      icon: Icon(Icons.error_outline_outlined),
                      onPressed: () {},
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(PromoPage());
                  },
                  child: Text(
                    "Tambah Promo",
                    style: TextStyle(
                      color: softOrangeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
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
                      "Member",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.error_outline_outlined),
                      onPressed: () {},
                    )
                  ],
                ),
                InkWell(
                  onTap: () {
                    Get.to(MemberPage());
                  },
                  child: Text(
                    "Tambah Member",
                    style: TextStyle(
                      color: softOrangeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      "Rp. ${currencyFormatter.format(cartProvider.totalPrice())}",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Disc / Promo",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Rp 0",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
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
                      isDeliveryChoosen ? "Rp 10.000" : "Rp 0",
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
                          ? "Rp. ${currencyFormatter.format(cartProvider.totalPrice() + 10000)}"
                          : "Rp. ${currencyFormatter.format(cartProvider.totalPrice())}",
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
    return Visibility(
      visible: isChoosen,
      child: Container(
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
                  "Delivery".toUpperCase(),
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var result = await Get.to(DeliveryAddress());
                  setState(() {
                    userAddress = result;
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
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    AddressInfo(
                      titleName: "Outlet Pengiriman",
                      bodyName: "Wiyung (15 Km)",
                    ),
                    AddressInfo(
                      titleName: "Tanggal Pengiriman",
                      bodyName: formatDate.format(date),
                    ),
                    AddressInfo(
                      titleName: "Jam Pengiriman",
                      bodyName: DateFormat.Hm().format(date),
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
      ),
    );
  }
}

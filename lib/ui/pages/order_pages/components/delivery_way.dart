import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_choose_button.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_info.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/select_payment.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class DeliveryWay extends StatefulWidget {
  @override
  _DeliveryWayState createState() => _DeliveryWayState();
}

class _DeliveryWayState extends State<DeliveryWay> {
  bool isDeliveryChoosen = false;
  bool isPickUpChoosen = false;

  @override
  Widget build(BuildContext context) {
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
          DeliveryInfo(isChoosen: isDeliveryChoosen),
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
                  isDeliveryChoosen ? "Rp 25.000" : "Rp 0",
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
                  onTap: () {},
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
                  onTap: () {},
                  child: Text(
                    "Bima Aprianto(4040333)",
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
                      "Rp 125.000",
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
                      "Rp 25.000",
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
                      isDeliveryChoosen ? "Rp 25.000" : "Rp 0",
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
                      "Rp 150.000",
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
          SelectPayment(),
        ],
      ),
    );
  }
}

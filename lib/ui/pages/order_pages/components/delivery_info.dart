import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/address_info.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({
    Key key,
    @required this.isChoosen,
  }) : super(key: key);

  final bool isChoosen;

  @override
  _DeliveryInfoState createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  UserAddressModel userAddress;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isChoosen,
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
              Container(
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
                                  : 'RUMAH BIMA - Prambanan Residance Surabaya',
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
                      bodyName: "06 Agustus 2021",
                    ),
                    AddressInfo(
                      titleName: "Jam Pengiriman",
                      bodyName: "15:00",
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

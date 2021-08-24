import 'dart:math';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class OutletsHomeCity extends StatelessWidget {
  const OutletsHomeCity({
    Key key,
    @required this.size,
    this.outletModel,
    this.currentPosition,
  }) : super(key: key);

  final Size size;
  final OutletModel outletModel;
  final Position currentPosition;

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
    return InkWell(
      onTap: () {
        Get.back(result: outletModel.title);
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[400]),
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15),
            topRight: const Radius.circular(15),
            bottomLeft: const Radius.circular(15),
            bottomRight: const Radius.circular(15),
          ),
        ),
        child: Column(
          children: <Widget>[
            RawMaterialButton(
              onPressed: null,
              elevation: 2.0,
              fillColor: softOrangeColor,
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.white,
              ),
              padding: EdgeInsets.zero,
              shape: CircleBorder(),
            ),
            Text(
              outletModel.title.toUpperCase(),
              style: TextStyle(
                color: softOrangeColor,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              outletModel.address,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.clip,
              textAlign: TextAlign.center,
            ),
            Text(
              "Telp :" + "${outletModel.phone}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            if (currentPosition != null)
              Text(
                // "10KM",
                calculateDistance(
                      currentPosition.latitude,
                      currentPosition.longitude,
                      outletModel.latitude,
                      outletModel.longitude,
                    ).ceil().toString() +
                    " KM",
                style: TextStyle(
                  color: softOrangeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
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

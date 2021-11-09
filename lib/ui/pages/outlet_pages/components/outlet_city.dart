import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class OutletsCity extends StatelessWidget {
  const OutletsCity({
    Key key,
    @required this.size,
    this.outletModel,
  }) : super(key: key);

  final Size size;
  final OutletModel outletModel;

  @override
  Widget build(BuildContext context) {
    handleLaunchMap() async {
      if (await canLaunch(outletModel.url)) {
        await launch(outletModel.url);
      } else {
        throw 'Could not open the map.';
      }
    }

    return Container(
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
          InkWell(
            onTap: handleLaunchMap,
            child: Text(
              "LIHAT PETA --->",
              style: TextStyle(
                color: choclateColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_counter.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class NewItemCard extends StatelessWidget {
  const NewItemCard({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    void showDialogWithFields() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(18.0),
              ),
            ),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: 180,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(18.0)),
                        child: Image.asset(
                          "assets/images/banner_promo.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Image.asset(
                      //   "assets/images/banner_promo.png",
                      //   fit: BoxFit.scaleDown,
                      // ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          "assets/images/vec_love.png",
                          height: 25,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Roti Baper Coklat",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Rp. 2.000",
                    style: TextStyle(
                      color: softOrangeColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  CartCounter(),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: softOrangeColor,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Masukkan Keranjang".toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        showDialogWithFields();
      },
      child: Container(
        height: 200,
        width: 150,
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 5,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "assets/images/banner_promo.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/vec_love.png",
                    height: 25,
                    width: 25,
                  ),
                ),
              ],
            ),
            Text(
              "Roti Baper \nCoklat",
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Text(
              "Rp. 2.000",
              style: TextStyle(
                color: choclateColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

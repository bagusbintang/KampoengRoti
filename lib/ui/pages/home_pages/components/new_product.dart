import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_counter.dart';
import 'package:kampoeng_roti/ui/pages/product_pages/components/pop_up_product.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class NewItemCard extends StatelessWidget {
  const NewItemCard({
    Key key,
    this.index,
    this.product,
    this.userModel,
  }) : super(key: key);
  final int index;
  final ProductModel product;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');

    return InkWell(
      onTap: () {
        showDialogProduct(context);
      },
      child: Container(
        // height: 200,
        // width: 150,
        // margin: EdgeInsets.symmetric(
        //     vertical: 5.0, horizontal: 10),
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
              spreadRadius: 1,
              blurRadius: 0,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10.0)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (product.status == 1)
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
            SizedBox(
              height: 10,
            ),
            Text(
              product.title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              // "Rp. ${product.price}",
              "Rp. ${currencyFormatter.format(product.price)}",
              style: TextStyle(
                color: choclateColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            // Spacer(),
          ],
        ),
      ),
    );
  }

  Future showDialogProduct(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopUpProduct(
          product: product,
          userModel: userModel,
        );
      },
    );
  }
}

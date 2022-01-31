import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/product_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class PopUpProduct extends StatelessWidget {
  const PopUpProduct({
    Key key,
    this.product,
    this.userModel,
  }) : super(key: key);

  final ProductModel product;
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int numbOfText = 1;
    return StatefulBuilder(
      builder: (context, setState) {
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
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
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
                  height: 2,
                ),
                Text(
                  // "Rp. ${product.price}",
                  "Rp ${currencyFormatter.format(product.price)}",
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
                // CartCounter(),
                Container(
                  height: 25,
                  width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                      right: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.remove,
                          size: 20,
                        ),
                        onPressed: () {
                          if (numbOfText > 1) {
                            setState(() {
                              numbOfText--;
                            });
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Text(
                          numbOfText.toString().padLeft(2, "0"),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.add,
                          size: 20,
                        ),
                        onPressed: () {
                          setState(() {
                            numbOfText++;
                          });
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Consumer<CartProvider>(
                    builder: (context, value, child) => FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      color: softOrangeColor,
                      onPressed: () {
                        // value.addCart(product, numbOfText);
                        cartProvider.addCart(
                          userId: userModel.id,
                          productId: product.id,
                          quantity: numbOfText,
                        );
                        Navigator.pop(context);
                        // if (await cartProvider.addCart(
                        //   userId: userModel.id,
                        //   productId: product.id,
                        //   quantity: numbOfText,
                        // )) {
                        //   Get.snackbar(
                        //     null,
                        //     "Tambah Item Berhasil !",
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     backgroundColor: softOrangeColor,
                        //     margin: EdgeInsets.symmetric(
                        //         horizontal: 15, vertical: 15),
                        //   );
                        //   Navigator.pop(context);
                        // } else {
                        //   Get.snackbar(
                        //     null,
                        //     "Tambah Item Gagal !",
                        //     snackPosition: SnackPosition.BOTTOM,
                        //     backgroundColor: softOrangeColor,
                        //     margin: EdgeInsets.symmetric(
                        //         horizontal: 15, vertical: 15),
                        //   );
                        // }
                      },
                      child: Text(
                        "Masukkan Keranjang".toUpperCase(),
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

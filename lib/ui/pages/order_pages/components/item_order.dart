import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_counter_shop.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class ItemOrder extends StatelessWidget {
  const ItemOrder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  "assets/images/product_1.png",
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Roti Baper Coklat",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Rp 20.000",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: softOrangeColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Rp 2.000 / biji",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: softOrangeColor,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          CartCounterShop(),
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "Notes",
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/images/icon_writing.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: ImageIcon(
                                    AssetImage(
                                      "assets/images/icon_bin.png",
                                    ),
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
        ),
      ],
    );
  }
}
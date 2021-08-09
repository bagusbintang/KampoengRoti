import 'package:flutter/material.dart';

class CartCounterShop extends StatefulWidget {
  @override
  _CartCounterShopState createState() => _CartCounterShopState();
}

class _CartCounterShopState extends State<CartCounterShop> {
  int numbOfText = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.grey[300],
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
            padding: const EdgeInsets.symmetric(horizontal: 1),
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
    );
  }
}

import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  const CartCounter({
    Key key,
  }) : super(key: key);
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numbOfText = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

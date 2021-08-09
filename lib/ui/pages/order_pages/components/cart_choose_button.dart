import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class CartChooseButton extends StatelessWidget {
  const CartChooseButton({
    Key key,
    this.text,
    this.press,
    this.backgroundColor,
    this.textColor,
  }) : super(key: key);
  final String text;
  final Function press;
  final Color backgroundColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 60,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: backgroundColor,
          onPressed: press,
          child: Text(
            text.toUpperCase(),
            style: TextStyle(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}

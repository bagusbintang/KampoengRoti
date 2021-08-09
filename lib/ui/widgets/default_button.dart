import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: softOrangeColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class MiniButton extends StatelessWidget {
  const MiniButton({
    Key key,
    this.text,
    this.onpress,
  }) : super(key: key);
  final String text;
  final Function onpress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: softOrangeColor,
        onPressed: onpress,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

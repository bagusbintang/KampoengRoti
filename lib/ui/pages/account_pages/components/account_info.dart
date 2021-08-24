import 'package:flutter/material.dart';

class AccountInfo extends StatelessWidget {
  const AccountInfo({
    Key key,
    this.titleName,
    this.icon,
    this.pressed,
  }) : super(key: key);
  final String titleName;
  final Icon icon;
  final Function pressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pressed,
      child: Container(
        width: double.maxFinite,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: <Widget>[
                  icon,
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    titleName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
        ),
      ),
    );
  }
}

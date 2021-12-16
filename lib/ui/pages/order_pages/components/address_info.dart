import 'package:flutter/material.dart';

class AddressInfo extends StatelessWidget {
  const AddressInfo({
    Key key,
    this.titleName,
    this.bodyName,
    this.press,
  }) : super(key: key);
  final String titleName;
  final String bodyName;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: press,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white),
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  titleName,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[500], fontSize: 8),
                ),
              ),
              Container(
                child: Text(
                  bodyName,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

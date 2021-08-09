import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class ListKategori extends StatelessWidget {
  const ListKategori({
    Key key,
    this.image,
    this.kategori,
    this.index,
  }) : super(key: key);
  final String image;
  final String kategori;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // padding: EdgeInsets.all(5),
        height: 150,
        width: 150,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 3, color: choclateColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  "assets/images/banner_promo.png",
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              kategori,
              style:
                  TextStyle(color: choclateColor, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}

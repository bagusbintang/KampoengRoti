import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class ListKategori extends StatelessWidget {
  const ListKategori({
    Key key,
    this.index,
    this.categoryModel,
    this.tap,
  }) : super(key: key);
  final int index;
  final CategoryModel categoryModel;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        // padding: EdgeInsets.all(5),
        height: 200,
        width: 100,
        child: Column(
          children: [
            catCard(),
            Text(
              categoryModel.title,
              style:
                  TextStyle(color: choclateColor, fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Card catCard() {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(width: 3, color: choclateColor)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          categoryModel.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

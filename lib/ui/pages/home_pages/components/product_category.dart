import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class ListKategori extends StatelessWidget {
  const ListKategori({
    Key key,
    this.index,
    this.categoryModel,
  }) : super(key: key);
  final int index;
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        // padding: EdgeInsets.all(5),
        height: 100,
        width: 100,
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(width: 3, color: choclateColor)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  categoryModel.imageUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Text(
              categoryModel.title,
              style:
                  TextStyle(color: choclateColor, fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}

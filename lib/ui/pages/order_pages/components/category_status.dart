import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class CategoryStatus extends StatefulWidget {
  const CategoryStatus({Key key}) : super(key: key);

  @override
  _CategoryStatusState createState() => _CategoryStatusState();
}

class _CategoryStatusState extends State<CategoryStatus> {
  List<String> categoryStatus = [
    "Menunggu Pembayaran",
    "Pesanan Diproses",
    "Pesanan Diterima",
    "Pesanan Selesai"
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryStatus.length,
        itemBuilder: (context, index) => buildCategory(index),
      ),
    );
  }

  Widget buildCategory(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            border: Border.all(color: Colors.black12),
            color: selectedIndex == index ? choclateColor : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              categoryStatus[index],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/components/new_product.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/components/product_category.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/cart_counter.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

// created by - Bagus *2021-04-07*
class ProductPages extends StatefulWidget {
  @override
  _ProductPagesState createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {
  final List dummyGrid = List.generate(10, (index) => '$index');
  List<Map<String, String>> categoryList = [
    {
      "image": "assets/images/banner_promo.png",
      "cat_name": "Roti",
    },
    {
      "image": "assets/images/banner_promo.png",
      "cat_name": "Roti Jumbo",
    },
    {
      "image": "assets/images/banner_promo.png",
      "cat_name": "Brownies",
    },
    {
      "image": "assets/images/banner_promo.png",
      "cat_name": "Pastry",
    },
  ];
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: MainAppBar(),
      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Kategori Produk",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: choclateColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: choclateColor,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        height: 150.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoryList.length,
                          itemBuilder: (context, index) => ListKategori(
                            image: categoryList[index]["image"],
                            kategori: categoryList[index]["cat_name"],
                            index: index,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                textFieldSearch(
                    "Cari Produk di Kampoeng Roti", Icon(Icons.search)),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "ROTI TAWAR",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: double.infinity),
                  child: Container(
                    child: GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      // childAspectRatio: .6,
                      children: dummyGrid
                          .map(
                            (p) => GestureDetector(
                              onTap: () {
                                showDialogWithFields();
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                // margin: EdgeInsets.symmetric(
                                //     vertical: 5.0, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      offset: Offset(
                                          0, 2), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(10.0)),
                                          child: Image.asset(
                                            "assets/images/banner_promo.png",
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/images/vec_love.png",
                                            height: 25,
                                            width: 25,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Roti Baper Coklat",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Spacer(),
                                    Text(
                                      "Rp. 2.000",
                                      style: TextStyle(
                                        color: choclateColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Theme textFieldSearch(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[800]),
            hintText: text,
            prefixIcon: icon,
            fillColor: Colors.grey[300]),
      ),
    );
  }

  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
          ),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 180,
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18.0)),
                      child: Image.asset(
                        "assets/images/banner_promo.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    // Image.asset(
                    //   "assets/images/banner_promo.png",
                    //   fit: BoxFit.scaleDown,
                    // ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image.asset(
                        "assets/images/vec_love.png",
                        height: 25,
                        width: 25,
                      ),
                    ),
                  ],
                ),
                Text(
                  "Roti Baper Coklat",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rp. 2.000",
                  style: TextStyle(
                    color: softOrangeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 8,
                ),
                CartCounter(),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: softOrangeColor,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Masukkan Keranjang".toUpperCase(),
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

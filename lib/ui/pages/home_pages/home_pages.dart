import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'dart:math' as math;

import 'components/new_product.dart';
import 'components/product_category.dart';

// created by - Bagus *2021-04-07*

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int currentPage = 0;
  List<Map<String, String>> imageList = [
    {"image": "assets/images/banner.png"},
    {"image": "assets/images/kategori1.png"},
    {"image": "assets/images/kategori2.png"},
  ];
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
  final List dummyGrid = List.generate(10, (index) => '$index');
  @override
  Widget build(BuildContext context) {
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
            SizedBox(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    // padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            "assets/images/banner_promo.png",
                            height: 200.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          imageList.length, (index) => buildDot(index: index)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Image.asset(
                                "assets/images/ic_nearme.png",
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "NEAR ME",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Image.asset(
                                "assets/images/ic_promo.png",
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "PROMO",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Image.asset(
                                "assets/images/ic_paket.png",
                                fit: BoxFit.cover,
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "PAKET",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  //CONTAINER HORIZONTAL LISTVIEW
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
                          margin: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
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
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Produk Baru",
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
                        SizedBox(
                          width: double.infinity,
                          height: 400,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dummyGrid.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio: 3 / 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10),
                            itemBuilder: (context, index) {
                              return NewItemCard();
                              // GridTile(
                              //     child: Container(
                              //         color: Colors.blue[200],
                              //         alignment: Alignment.center,
                              //         child: Text(dummyGrid[index])));
                            },
                          ),
                        ),
                        // NewItemCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? choclateColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

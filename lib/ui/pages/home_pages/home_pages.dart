import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/outlet_home_page.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import 'components/new_product.dart';
import 'components/product_category.dart';

// created by - Bagus *2021-04-07*

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  Position _currentPosition;
  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print("lat : " +
            _currentPosition.latitude.toString() +
            "long : " +
            _currentPosition.longitude.toString());
      });
    }).catchError((e) {
      print(e);
    });
  }

  int currentPage = 0;
  String selectedOutlet = "Pilih Outlet";
  List<Map<String, String>> imageList = [
    {"image": "assets/images/banner.png"},
    {"image": "assets/images/kategori1.png"},
    {"image": "assets/images/kategori2.png"},
  ];
  final List dummyGrid = List.generate(10, (index) => '$index');

  ProductProvider productProvider;
  CategoryProvider categoryProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    categoryProvider = Provider.of<CategoryProvider>(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Column(
          children: <Widget>[
            MainAppBar(),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: softOrangeColor,
                  onPressed: () async {
                    _getCurrentLocation();
                    String result = await Get.to(() => OutletHomePage(
                          currentPosition: _currentPosition,
                        ));
                    setState(() {
                      if (result != null) {
                        selectedOutlet = "Outlet " + result;
                      }
                    });
                  },
                  child: Text(
                    selectedOutlet.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
                    height: 10,
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
                              onPressed: () {
                                Get.to(() => PromoPage());
                              },
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
                          height: 150,
                          child: FutureBuilder(
                            future: categoryProvider.getCategories(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryProvider.categories.length,
                                itemBuilder: (context, index) => ListKategori(
                                  index: index,
                                  categoryModel:
                                      categoryProvider.categories[index],
                                  tap: () {},
                                ),
                              );
                            },
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
                          height: 450,
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: dummyGrid.length,
                            gridDelegate:
                                SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250,
                              childAspectRatio: 5 / 4,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                            ),
                            itemBuilder: (context, index) {
                              return NewItemCard();
                            },
                          ),
                        ),
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/models/outlet_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/banner_provider.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/outlet_home_page.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';
import 'components/new_product.dart';
import 'components/product_category.dart';

// created by - Bagus *2021-04-07*

class HomePages extends StatefulWidget {
  @override
  _HomePagesState createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  int currentPage = 0;
  int outletId = 0;
  String selectedOutlet = "Pilih Outlet";
  List<Map<String, String>> imageList = [
    {"image": "assets/images/banner.png"},
    {"image": "assets/images/banner.png"},
    {"image": "assets/images/banner.png"},
  ];

  ProductProvider productProvider;
  CategoryProvider categoryProvider;
  BannerProvider bannerProvider;
  CartProvider cartProvider;
  CategorySingleton categorySingleton = CategorySingleton();

  UserModel userModel;
  void getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    // outletId = await MySharedPreferences.instance.getIntegerValue("outletId");
    // if (outletId == null) {
    //   outletId = 0;
    // }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    getUserModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserSingleton userSingleton = UserSingleton();
    final MainPageController mainPageController =
        Get.put(MainPageController(), permanent: true);
    productProvider = Provider.of<ProductProvider>(context);
    categoryProvider = Provider.of<CategoryProvider>(context);
    bannerProvider = Provider.of<BannerProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);
    selectedOutlet = "Outlet " + userSingleton.outlet.title;

    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130),
        child: Column(
          children: <Widget>[
            // MainAppBar(),
            AppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              backgroundColor: softOrangeColor,
              elevation: 0,
              title: InkWell(
                onTap: () async {
                  Get.to(DeliveryAddress()).then((value) => setState(() {
                        if (value != null) {
                          userSingleton.address = value;
                          userSingleton.outlet =
                              userSingleton.address.outletModel;
                        }
                      }));
                  // var result = await Get.to(DeliveryAddress());

                  // setState(() {
                  //   if (result != null) {
                  //     userSingleton.address = result;
                  //     userSingleton.outlet = userSingleton.address.outletModel;
                  //   }
                  // });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Colors.white),
                  // padding: EdgeInsets.only(left: 5),
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Lokasi Pengiriman',
                                style: TextStyle(
                                    color: Colors.grey[500], fontSize: 10),
                              ),
                            ),
                            Container(
                              child: Text(
                                userSingleton.address != null
                                    ? userSingleton.address.tagAddress
                                            .toUpperCase() +
                                        " - " +
                                        userSingleton.address.address
                                    : 'Alamat utama belum ditentukan. ',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: ImageIcon(
                          AssetImage("assets/images/icon_edit.png"),
                          color: Colors.grey,
                          size: 20,
                        ),
                        onPressed: null,
                        // () async {
                        //   // Get.to(DeliveryAddress());
                        //   var result = await Get.to(DeliveryAddress());
                        //   setState(() {
                        //     if (result != null) {
                        //       userSingleton.address = result;
                        //       userSingleton.outlet =
                        //           userSingleton.address.outletModel;
                        //     }
                        //   });
                        // },
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                    icon: Image.asset(
                      "assets/images/icon_notif.png",
                      height: 25,
                      width: 25,
                    ),
                    onPressed: () {
                      // do something
                      // Get.to(() => DetailTransaction());
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        icon:
                            // Align(
                            //   alignment: Alignment.bottomCenter,
                            //   child: Icon(Icons.shopping_cart_rounded,
                            //       color: Colors.black, size: 25),
                            // ),
                            // onPressed: () {
                            //   Get.to(() => OrderPages());
                            // },
                            Image.asset(
                          "assets/images/icon_cart.png",
                          height: 27,
                          width: 27,
                        ),
                        onPressed: () {
                          Get.to(OrderPages()).then((value) => setState(() {}));
                          // do something
                        },
                      ),
                      Positioned(
                        right: 3,
                        // left: 0,
                        top: 3,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                            color: softOrangeColor,
                          ),
                          // child: Consumer<CartProvider>(
                          //   builder: (context, value, child) => Text(
                          //     value.totalCart().toString(),
                          //     style: TextStyle(
                          //       fontSize: 8,
                          //     ),
                          //   ),
                          // ),
                          child: FutureBuilder(
                            future: cartProvider.getCart(
                                userId: userSingleton.user.id),
                            builder: (context, snapshot) => Text(
                              cartProvider.totalCart().toString(),
                              style: TextStyle(
                                fontSize: 8,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                    // _getCurrentLocation();
                    OutletModel result = await Get.to(OutletHomePage(
                      // currentPosition: _currentPosition,
                      userModel: userModel,
                    ));
                    setState(() {
                      if (result != null) {
                        selectedOutlet = "Outlet " + result.title;
                        userSingleton.outlet = result;
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
                  FutureBuilder(
                    future: bannerProvider.getBanners(),
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 200,
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  currentPage = value;
                                });
                              },
                              itemCount: bannerProvider.banners.length,
                              itemBuilder: (context, index) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        bannerProvider.banners[index].imageUrl,
                                        height: 200.0,
                                        width: double.infinity,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  bannerProvider.banners.length,
                                  (index) => buildDot(index: index)),
                            ),
                          ),
                        ],
                      );
                    },
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
                              iconSize: 25,
                              icon: Image.asset(
                                "assets/images/ic_nearme.png",
                              ),
                              onPressed: () {},
                            ),
                            Text(
                              "Near Me",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30,
                              icon: Image.asset(
                                "assets/images/ic_promo.png",
                              ),
                              onPressed: () {
                                Get.to(PromoPage(
                                  fromPayment: false,
                                ));
                              },
                            ),
                            Text(
                              "Promo",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset(
                                "assets/images/ic_paket.png",
                                fit: BoxFit.cover,
                              ),
                              onPressed: () {
                                Get.snackbar(
                                  "Paket belum ada",
                                  "Oops.. paket baru sedang kami persiapkan nih, ditunggu ya..",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: softOrangeColor,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 15),
                                );
                              },
                            ),
                            Text(
                              "Paket",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
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
                                    fontSize: 14,
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
                            future: categoryProvider.getCategories(
                                outletId: userSingleton.outlet.id),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: categoryProvider.categories.length,
                                itemBuilder: (context, index) => ListKategori(
                                  index: index,
                                  categoryModel:
                                      categoryProvider.categories[index],
                                  tap: () {
                                    mainPageController.changeTabIndex(1);
                                    categorySingleton.id =
                                        categoryProvider.categories[index].id;
                                    categorySingleton.title = categoryProvider
                                        .categories[index].title;
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Produk Baru",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: choclateColor,
                                    fontWeight: FontWeight.w700),
                              ),
                              // IconButton(
                              //   icon: Icon(
                              //     Icons.arrow_forward_ios,
                              //     color: choclateColor,
                              //   ),
                              //   onPressed: () {},
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // SizedBox(
                        //   height: 450,
                        //   child: GridView.builder(
                        //     scrollDirection: Axis.vertical,
                        //     itemCount: 6,
                        //     gridDelegate:
                        //         SliverGridDelegateWithMaxCrossAxisExtent(
                        //       maxCrossAxisExtent: 250,
                        //       childAspectRatio: 5 / 6,
                        //       crossAxisSpacing: 0,
                        //       mainAxisSpacing: 0,
                        //     ),
                        //     itemBuilder: (context, index) {
                        //       return NewItemCard();
                        //     },
                        //   ),
                        // ),

                        ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: double.infinity),
                          child: FutureBuilder(
                            future: productProvider.getNewProducts(
                                outletId: userSingleton.outlet.id),
                            builder: (context, snapshot) {
                              return Container(
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 4 / 6,
                                  children: productProvider.newProducts
                                      .map(
                                        (product) => NewItemCard(
                                          product: product,
                                          userModel: userSingleton.user,
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
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

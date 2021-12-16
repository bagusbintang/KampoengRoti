import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/components/product_category.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/pages/product_pages/components/product_card.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

// created by - Bagus *2021-04-07*
class ProductPages extends StatefulWidget {
  @override
  _ProductPagesState createState() => _ProductPagesState();
}

class _ProductPagesState extends State<ProductPages> {
  // int outletId = 0;
  String search;
  TextEditingController searchController = TextEditingController(text: '');
  CategorySingleton categorySingleton = CategorySingleton();
  UserSingleton userSingleton = UserSingleton();

  UserModel userModel;
  void getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    // outletId = await MySharedPreferences.instance.getIntegerValue("outletId");
    // if (outletId == null) {
    //   outletId = 0;
    // }
    // setState(() {});
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
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    // categoryProvider.getCategories();
    // productProvider.getProducts();
    return Scaffold(
      backgroundColor: Colors.transparent,
      // backgroundColor: softOrangeColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child:
            //MainAppBar(),
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
                      userSingleton.outlet = userSingleton.address.outletModel;
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
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
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
                        future:
                            cartProvider.getCart(userId: userSingleton.user.id),
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
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        height: 150.0,
                        child: FutureBuilder(
                          future: categoryProvider.getCategories(
                              outletId: userSingleton.outlet.id),
                          builder: (context, snapshot) {
                            if (categoryProvider.categories.length > 0) {
                              categorySingleton.title =
                                  categoryProvider.categories[0].title;
                              categorySingleton.id =
                                  categoryProvider.categories[0].id;
                            }

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: categoryProvider.categories.length,
                              itemBuilder: (context, index) => ListKategori(
                                index: index,
                                categoryModel:
                                    categoryProvider.categories[index],
                                tap: () {
                                  print("diklik");
                                  setState(() {
                                    categorySingleton.title = categoryProvider
                                        .categories[index].title;
                                    categorySingleton.id =
                                        categoryProvider.categories[index].id;
                                    searchController.clear();
                                    search = null;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                textFieldSearch(
                    "Cari Produk...",
                    Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    )),
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
                          categorySingleton.title,
                          style: TextStyle(
                              fontSize: 14,
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
                  child: FutureBuilder(
                    future: productProvider.getProducts(
                      catId: categorySingleton.id,
                      outletId: userSingleton.outlet.id,
                      search: search == null
                          ? "all"
                          : search == ''
                              ? "all"
                              : search,
                    ),
                    builder: (context, snapshot) {
                      return productProvider.products.length == 0
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Center(
                                child: Text(
                                  "Tidak menenukan hasil, mohon menggunakan kata kunci lainnya",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : Container(
                              child: GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),
                                childAspectRatio: .7,
                                children: productProvider.products
                                    .map(
                                      (product) => ProductCard(
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
        controller: searchController,
        onChanged: (value) {
          if (value != null && value != '') {
            search = value;
          } else {
            search = "all";
          }
          // value != "" ? search = value : search = "all";
        },
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
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
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kampoeng_roti/models/category_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/components/product_category.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/components/main_app_bar.dart';
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
  // UserModel userModel;
  // void getUserModel() async {
  //   userModel = await MySharedPreferences.instance.getUserModel("user");
  //   // outletId = await MySharedPreferences.instance.getIntegerValue("outletId");
  //   // if (outletId == null) {
  //   //   outletId = 0;
  //   // }
  //   setState(() {});
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   getUserModel();
  // }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    // categoryProvider.getCategories();
    // productProvider.getProducts();
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
                            categorySingleton.title =
                                categoryProvider.categories[0].title;
                            categorySingleton.id =
                                categoryProvider.categories[0].id;
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

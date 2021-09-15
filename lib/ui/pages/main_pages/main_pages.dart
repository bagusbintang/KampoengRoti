import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_pages.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/home_pages.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/pages/outlet_pages/outlet_pages.dart';
import 'package:kampoeng_roti/ui/pages/product_pages/product_pages.dart';

import 'package:kampoeng_roti/ui/theme/theme.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectedIndex = 0;
  DateTime currentBackPressTime;
  List<Widget> _widgetOptions = <Widget>[
    HomePages(),
    ProductPages(),
    OrderPages(),
    OutletPages(),
    AccountPages(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 6)) {
      currentBackPressTime = now;
      Get.snackbar(
        null,
        "Tekan sekali lagi untuk menutup aplikasi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: softOrangeColor,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    final MainPageController mainPageController =
        Get.put(MainPageController(), permanent: true);
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            image: DecorationImage(
                image: AssetImage("assets/images/kr_background.png"),
                fit: BoxFit.cover),
          ),
          child: Obx(() => IndexedStack(
                index: mainPageController.tabIndex.value,
                children: [
                  HomePages(),
                  ProductPages(),
                  OrderPages(),
                  OutletPages(),
                  AccountPages(),
                ],
              )),
          // _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar:
          buildBottomNavigationMenu(context, mainPageController),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home,
      //           size: 25,
      //         ),
      //         label: 'Home'),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(
      //           AssetImage("assets/images/icon_product.png"),
      //           size: 25,
      //         ),
      //         label: 'Product'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.shopping_cart,
      //           size: 25,
      //         ),
      //         label: 'Order'),
      //     BottomNavigationBarItem(
      //         icon: ImageIcon(
      //           AssetImage("assets/images/icon_outlets.png"),
      //           size: 25,
      //         ),
      //         label: 'Outlets'),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.person,
      //           size: 25,
      //         ),
      //         label: 'Account'),
      //   ],
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.white,
      //   elevation: 5.0,
      //   currentIndex: _selectedIndex,
      //   unselectedItemColor: Colors.black87,
      //   selectedItemColor: choclateColor,
      //   onTap: _onItemTap,
      // ),
    );
  }
}

buildBottomNavigationMenu(context, mainPageController) {
  return Obx(() => MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: SizedBox(
        height: 54,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: mainPageController.changeTabIndex,
          currentIndex: mainPageController.tabIndex.value,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black87,
          selectedItemColor: choclateColor,
          // unselectedLabelStyle: unselectedLabelStyle,
          // selectedLabelStyle: selectedLabelStyle,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 18,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/icon_product.png"),
                  size: 18,
                ),
                label: 'Product'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: 18,
                ),
                label: 'Order'),
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/images/icon_outlets.png"),
                  size: 18,
                ),
                label: 'Pilih Outlet'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  size: 18,
                ),
                label: 'Account'),
          ],
        ),
      )));
}

class MainPageController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

import 'package:flutter/material.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_pages.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/home_pages.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/order_pages.dart';
import 'package:kampoeng_roti/ui/pages/outlet_pages/outlet_pages.dart';
import 'package:kampoeng_roti/ui/pages/product_pages/product_pages.dart';

import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class MainPages extends StatefulWidget {
  @override
  _MainPagesState createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _selectedIndex = 0;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          image: DecorationImage(
              image: AssetImage("assets/images/kr_background.png"),
              fit: BoxFit.cover),
        ),
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_product.png")),
              label: 'Product'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Pesanan'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/icon_outlets.png")),
              label: 'Outlets'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 5.0,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.black87,
        selectedItemColor: choclateColor,
        onTap: _onItemTap,
      ),
    );
  }
}

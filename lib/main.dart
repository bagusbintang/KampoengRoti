import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/faq_provider.dart';
import 'package:kampoeng_roti/providers/outlet_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/ui/pages/splash_pages/splash_page.dart';
import 'package:provider/provider.dart';

// created by - Bagus *2021-04-07*

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FaqProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OutletProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Poppins-Regular",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
      ),
    );
  }
}

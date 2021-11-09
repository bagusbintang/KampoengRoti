import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/providers/banner_provider.dart';
import 'package:kampoeng_roti/providers/cart_provider.dart';
import 'package:kampoeng_roti/providers/category_provider.dart';
import 'package:kampoeng_roti/providers/city_provider.dart';
import 'package:kampoeng_roti/providers/faq_provider.dart';
import 'package:kampoeng_roti/providers/order_provider.dart';
import 'package:kampoeng_roti/providers/outlet_provider.dart';
import 'package:kampoeng_roti/providers/product_provider.dart';
import 'package:kampoeng_roti/providers/province_provider.dart';
import 'package:kampoeng_roti/providers/user_address_provider.dart';
import 'package:kampoeng_roti/shared_preferences.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/splash_pages/splash_page.dart';
import 'package:provider/provider.dart';

// created by - Bagus *2021-04-07*

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = false;
  UserSingleton userSingleton = UserSingleton();
  isLoggedIn = await MySharedPreferences.instance.getLoginValue("LoggedIn");
  if (isLoggedIn) {
    UserModel userModel =
        await MySharedPreferences.instance.getUserModel("user");
    userSingleton.user = userModel;
    userSingleton.address = userModel.defaulAdress;
    userSingleton.outlet = userModel.defaulAdress.outletModel;
  }

  runApp(
    MainApp(isLoggedIn: isLoggedIn),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key key,
    @required this.isLoggedIn,
  }) : super(key: key);

  final bool isLoggedIn;

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
        ChangeNotifierProvider(
          create: (context) => UserAddressProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProvinceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => BannerProvider(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          fontFamily: "Poppins-Regular",
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: isLoggedIn == true ? MainPages() : SplashPage(),
      ),
    );
  }
}

// class MainApp extends StatelessWidget {
//   Widget home;
//   MainApp({this.home});
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => AuthProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CategoryProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => ProductProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => FaqProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => OutletProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CartProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => UserAddressProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => ProvinceProvider(),
//         ),
//         ChangeNotifierProvider(
//           create: (context) => CityProvider(),
//         ),
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           scaffoldBackgroundColor: Colors.white,
//           fontFamily: "Poppins-Regular",
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         home: widget,
//       ),
//     );
//   }
// }

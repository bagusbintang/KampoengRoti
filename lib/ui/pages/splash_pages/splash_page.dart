import 'package:flutter/material.dart';
import 'package:kampoeng_roti/ui/pages/splash_pages/components/splash_body.dart';

import '../../../sized_config.dart';

class SplashPage extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    // SizeConfig().init(context);
    return Scaffold(
      body: SplashBody(),
    );
  }
}

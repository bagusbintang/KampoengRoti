import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/auth_provider.dart';
import 'package:kampoeng_roti/shared_preferences.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_contact_us.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_edit_profile.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_faq.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_share_app.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/account_info.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/login_pages/login_pages.dart';
import 'package:kampoeng_roti/ui/pages/main_pages/main_pages.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/confirm_payment_page.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/member_page.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/detail_transaction.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/promo_page.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class AccountPages extends StatefulWidget {
  @override
  State<AccountPages> createState() => _AccountPagesState();
}

class _AccountPagesState extends State<AccountPages> {
  UserModel userModel;
  UserSingleton userSingleton = UserSingleton();
  // void getUserModel() async {
  //   userModel = await MySharedPreferences.instance.getUserModel("user");
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (mounted) {
      Future.delayed(Duration.zero, () async {
        AuthProvider authProvider =
            Provider.of<AuthProvider>(context, listen: false);
        userSingleton.user =
            await authProvider.refreshUser(userId: userSingleton.user.id);
      });
    }
    // getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final MainPageController mainPageController =
        Get.put(MainPageController(), permanent: true);
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 25),
              height: size.height / 5,
              width: size.width,
              decoration: BoxDecoration(
                color: softOrangeColor,
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RawMaterialButton(
                    onPressed: null,
                    elevation: 2.0,
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: softOrangeColor,
                      size: 50,
                    ),
                    padding: EdgeInsets.zero,
                    shape: CircleBorder(),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 50, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            // "Bima Aprianto Siono",
                            userSingleton.user.name,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            // "bima.aprianto@gmail.com",
                            userSingleton.user.email,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            // "+6281804643014",
                            userSingleton.user.phone != null
                                ? userSingleton.user.phone.toString()
                                : " - ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Get.to(EditProfile(),
                                arguments: userSingleton.user);
                          },
                          icon: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Ubah Profil",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AccountInfo(
              titleName: "Riwayat Transaksi",
              icon: Icon(
                Icons.history_edu,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                // Get.to(() => HistoryTransaction());
                Get.to(DetailTransaction(
                  userModel: userModel,
                ));
              },
            ),
            AccountInfo(
              titleName: "Alamat",
              icon: Icon(
                Icons.location_on,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(DeliveryAddress());
              },
            ),
            AccountInfo(
              titleName: "Promo",
              icon: Icon(
                Icons.next_plan,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(PromoPage(
                  fromPayment: false,
                ));
              },
            ),
            AccountInfo(
              titleName: "Bagi Aplikasi",
              icon: Icon(
                Icons.share,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(AccountShareApps());
              },
            ),
            AccountInfo(
              titleName: "Member Kampoeng Roti",
              icon: Icon(
                Icons.credit_card,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                if (userSingleton.user != null) {
                  if (userSingleton.user.isRequestMember == 1) {
                    Get.to(ConfirmPayment());
                  } else {
                    Get.to(MemberPage(
                      user: userSingleton.user,
                    ));
                  }
                } else {
                  Get.to(MemberPage(
                    user: userSingleton.user,
                  ));
                }
              },
            ),
            AccountInfo(
              titleName: "FAQ",
              icon: Icon(
                Icons.question_answer,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(AccountFAQ());
              },
            ),
            AccountInfo(
              titleName: "Hubungi Kami",
              icon: Icon(
                Icons.call,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () {
                Get.to(AccountContactUs());
              },
            ),
            AccountInfo(
              titleName: "Keluar",
              icon: Icon(
                Icons.logout,
                size: 30,
                color: softOrangeColor,
              ),
              pressed: () async {
                MySharedPreferences.instance.removeAll();
                userSingleton = null;
                mainPageController.changeTabIndex(0);
                Get.offAll(LoginPage());
              },
            ),
          ],
        ),
      ),
    );
  }
}

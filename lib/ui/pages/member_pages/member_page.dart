import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/confirm_register_member.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/register_member_body.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/unregister_member_body.dart';

class MemberPage extends StatelessWidget {
  // const MemberPage({
  //   Key key,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Member Kampoeng Roti",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kr_background2.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // UnregisterMemberBody(size: size),
          RegisMemberBody(size: size),
          // ConfirmRegisterMember(),
        ],
      ),
    );
  }
}

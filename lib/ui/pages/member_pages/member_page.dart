import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/confirm_register_member.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/register_member_body.dart';
import 'package:kampoeng_roti/ui/pages/member_pages/components/unregister_member_body.dart';

class MemberPage extends StatelessWidget {
  const MemberPage({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;

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
          user.memberNo == null
              ? UnregisterMemberBody(
                  size: size,
                  user: user,
                )
              : RegisMemberBody(
                  size: size,
                  user: user,
                ),
          // ConfirmRegisterMember(),
        ],
      ),
    );
  }
}

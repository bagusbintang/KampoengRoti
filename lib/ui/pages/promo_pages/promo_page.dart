import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/providers/promo_provider.dart';
import 'package:kampoeng_roti/ui/pages/promo_pages/components/promo_container.dart';
import 'package:provider/provider.dart';

class PromoPage extends StatelessWidget {
  const PromoPage({
    Key key,
    this.fromPayment,
  }) : super(key: key);
  final bool fromPayment;

  @override
  Widget build(BuildContext context) {
    PromoProvider promoProvider = Provider.of<PromoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Promo Kampoeng Roti",
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
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: FutureBuilder(
              future: promoProvider.getPromos(),
              builder: (context, snapshot) {
                return Column(
                  children: promoProvider.promos
                      .map((promo) => PromoContainer(
                            promoModel: promo,
                            fromPaymentPage: fromPayment,
                          ))
                      .toList(),
                );
              },
            )),
      ),
    );
  }
}

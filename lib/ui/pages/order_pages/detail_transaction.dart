import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/invoice_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/order_provider.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/category_status.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/components/delivery_transaction_container.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

class DetailTransaction extends StatefulWidget {
  @override
  _DetailTransactionState createState() => _DetailTransactionState();
}

class _DetailTransactionState extends State<DetailTransaction> {
  UserModel userModel;
  List<String> categoryStatus = [
    "Menunggu Pembayaran",
    "Pesanan Diproses",
    "Pesanan Diterima",
    "Pesanan Selesai"
  ];
  int selectedIndex = 0;
  // String selecetedStatus = "Menunggu Pembayaran";

  void getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    // getUserModel();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Daftar Transaksi",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: textFieldSearchTransaction(
                    "Cari Invoice, daftar transaksi, konfirmasi barang",
                    Icon(Icons.search)),
              ),
              SizedBox(
                height: 15,
              ),
              // CategoryStatus(),
              SizedBox(
                height: 35,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryStatus.length,
                  itemBuilder: (context, index) => buildCategory(index),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 20,
                thickness: 1,
              ),
              // Container(
              //   child: Column(
              //     children: List.generate(
              //       historyList.length,
              //       (index) => DeliveryTransactionContainer(
              //         imageUrl: historyList[index].imageUrl,
              //         invoice: historyList[index].invoice,
              //         statusInvoice: historyList[index].statusInvoice,
              //         date: historyList[index].date,
              //         itemName: historyList[index].itemName,
              //         statusOrder: historyList[index].statusOrder,
              //       ),
              //     ),
              //   ),
              // ),
              userModel != null
                  ? Container(
                      child: FutureBuilder(
                        future: orderProvider.getInvoices(userId: userModel.id),
                        builder: (context, snapshot) {
                          return Column(
                            children: orderProvider.invoices
                                .map((invoices) => DeliveryTransactionContainer(
                                      invoiceModel: invoices,
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Theme textFieldSearchTransaction(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 12),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[400]),
            hintText: text,
            suffixIcon: icon,
            fillColor: Colors.white),
      ),
    );
  }

  Widget buildCategory(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
            border: Border.all(color: Colors.black12),
            color: selectedIndex == index ? choclateColor : Colors.transparent,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Text(
              categoryStatus[index],
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selectedIndex == index ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

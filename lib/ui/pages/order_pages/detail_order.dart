import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kampoeng_roti/models/invoice_model.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/account_contact_us.dart';
import 'package:kampoeng_roti/ui/pages/account_pages/components/history_item_order.dart';
import 'package:kampoeng_roti/ui/pages/order_pages/confirm_order.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({
    Key key,
    this.invoiceModel,
  }) : super(key: key);
  final InvoiceModel invoiceModel;
  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat('#,###', 'ID');
    bool visibleButton;
    if (invoiceModel.iStatus == '1') {
      visibleButton = true;
    } else {
      visibleButton = false;
    }
    print("status : " + invoiceModel.iStatus);
    print("deliv : " + invoiceModel.iDelivery);
    // _statusInvoice = data;
    // if (_statusInvoice == 1) {
    //   _name = "Bima Aprianto Siono";
    //   _address =
    //       "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213";
    //   _phone = "081081808103";
    //   _titleStatus = "Alamat Pengirim";
    //   _status = "Delivery Order";
    //   _colorStatus = Colors.amber;
    // } else {
    //   _name = "Kampoeng Roti Wiyung";
    //   _address = "Jl. Raya Menganti No.19\nKota SBY, Jawa Timur 60228";
    //   _phone = "031-7526303";
    //   _titleStatus = "Alamat Pengambilan";
    //   _status = "Pickup Order";
    //   _colorStatus = Colors.orange;
    // }

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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                color: softOrangeColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Status Pesanan",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      invoiceModel.iHeaderStatus,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Tanggal Pemesanan",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      // "12 Desember 2021" + " | " + "05 AM - 10 AM",
                      invoiceModel.iHeaderDelivTime.toString(),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Alamat Pengiriman",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            )),
                        child: Text(
                          invoiceModel.iHeaderDelivMethod.toUpperCase(),
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    // "Bima Aprianto Siono (Rumah Prambanan)",
                    invoiceModel.iHeaderName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    // "Petemon Barat No. 223, Lakasantri, Lidah Kulon\nKota Surabaya, 60213",
                    invoiceModel.iHeaderAddress,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    // "No. Telpon : 081805512618",
                    "No. Telpon : ${invoiceModel.iHeaderPhone}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: choclateColor,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Pesanan akan kami antar ke alamat default anda.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Jika ingin mengganti alamat ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'klik disini',
                          style: TextStyle(
                            color: choclateColor,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Informasi Pembayaran",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Harga Belanja",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // "Rp 125.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderTotal)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Promo",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        // "Rp 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderPromoDisc)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Member",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        // "Rp 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderMemberDisc)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Biaya Pengiriman",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // "Rp 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderOngkir)}",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "TOTAL PAYMENT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        // "Rp 150.000",
                        "Rp. ${currencyFormatter.format(
                          invoiceModel.iHeaderTotal +
                              invoiceModel.iHeaderOngkir -
                              invoiceModel.iHeaderPromoDisc -
                              invoiceModel.iHeaderMemberDisc,
                        )}",
                        style: TextStyle(
                          color: choclateColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  )),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ringkasan Pesanan",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Container(
                    // child: Column(
                    //   children: List.generate(
                    //     3,
                    //     (index) => HistoryItemOrder(),
                    //   ),
                    // ),
                    child: Column(
                      children: invoiceModel.invDetail
                          .map((detail) => HistoryItemOrder(
                                invoiceDetailModel: detail,
                              ))
                          .toList(),
                    ),
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Ringkasan Pembayaran",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Harga Belanja",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        // "Rp. 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderTotal)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Promo",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        // "Rp. 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderPromoDisc)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Disc Member",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        // "Rp. 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderMemberDisc)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Biaya Antar",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        // "Rp. 25.000",
                        "Rp. ${currencyFormatter.format(invoiceModel.iHeaderOngkir)}",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        // "Rp. 75.000",
                        "Rp. ${currencyFormatter.format(
                          invoiceModel.iHeaderTotal +
                              invoiceModel.iHeaderOngkir -
                              invoiceModel.iHeaderPromoDisc -
                              invoiceModel.iHeaderMemberDisc,
                        )}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: choclateColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: visibleButton,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: <Widget>[
                    DefaultButton(
                      text: "KONFIRMASI PEMBAYARAN",
                      press: () {
                        Get.to(ConfirmOrder());
                      },
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                children: <Widget>[
                  Text(
                    "Untuk Bantuan & Pertanyaan:",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[400],
                    ),
                  ),
                  FlatButton(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.amber,
                    onPressed: () {
                      Get.to(AccountContactUs());
                    },
                    child: Text(
                      "Hubungi Kami",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

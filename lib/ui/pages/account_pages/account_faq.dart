import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

class AccountFAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "FAQ",
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
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                color: softOrangeColor,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Frequently Asked Questions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Silahkan membaca FAQ kami sebelum bertanya lebih lanjut",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            FaqBody(),
          ],
        ),
      ),
    );
  }
}

class Faq {
  bool isExpanded;
  int number;
  String header;
  String body;

  Faq(this.number, this.header, this.body, this.isExpanded);
}

class FaqBody extends StatefulWidget {
  @override
  _FaqBodyState createState() => _FaqBodyState();
}

class _FaqBodyState extends State<FaqBody> {
  List<Faq> _faqList = [
    Faq(
      01,
      "Kapan Barang Akan Dikirimkan?",
      "Kampoeng Roti doeloe berdiri pada tahun 2012 dan memiliki lebih dari 17 cabang yang telah tersebar di Surabaya, Sidoarjo, Gresik, Madura, dan Malang. Silahkan mengunjungi outlet terdekat kami.",
      false,
    ),
    Faq(
      02,
      "Bagaimana Melakukan Pembayaran?",
      "Kampoeng Roti doeloe berdiri pada tahun 2012 dan memiliki lebih dari 17 cabang yang telah tersebar di Surabaya, Sidoarjo, Gresik, Madura, dan Malang. Silahkan mengunjungi outlet terdekat kami.",
      false,
    ),
    Faq(
      03,
      "Apakah Bisa Pesan Ulang?",
      "Kampoeng Roti doeloe berdiri pada tahun 2012 dan memiliki lebih dari 17 cabang yang telah tersebar di Surabaya, Sidoarjo, Gresik, Madura, dan Malang. Silahkan mengunjungi outlet terdekat kami.",
      false,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _faqList[index].isExpanded = !isExpanded;
        });
      },
      children: _faqList.map<ExpansionPanel>((Faq item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
                title: RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: item.number.toString().padLeft(2, "0"),
                    style: TextStyle(
                      color: choclateColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: "  " + item.header,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ));
          },
          body: ListTile(
            title: Text(
              item.body,
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

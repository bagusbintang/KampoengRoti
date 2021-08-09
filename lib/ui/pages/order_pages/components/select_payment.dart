import 'package:flutter/material.dart';

class Payment {
  String payment;

  Payment(this.payment);
}

class SelectPayment extends StatefulWidget {
  @override
  _SelectPaymentState createState() => _SelectPaymentState();
}

class _SelectPaymentState extends State<SelectPayment> {
  Payment selectedPayment;
  List<Payment> paymentList = [
    Payment("BCA"),
    Payment("Mandiri"),
    Payment("BRI"),
    Payment("TUNAI"),
  ];
  List<DropdownMenuItem> generateItems(List<Payment> paymentList) {
    List<DropdownMenuItem> items = [];
    for (var item in paymentList) {
      items.add(
        DropdownMenuItem(
          child: Text(item.payment, textAlign: TextAlign.center),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 15,
          ),
          Text(
            "Cara Pembayaran",
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15),
                topRight: const Radius.circular(15),
                bottomLeft: const Radius.circular(15),
                bottomRight: const Radius.circular(15),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: Theme(
                data: Theme.of(context).copyWith(
                  canvasColor: Colors.white,
                ),
                child: DropdownButton(
                  value: selectedPayment,
                  items: generateItems(paymentList),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  iconEnabledColor: Colors.black,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Pilih Metode Pembayaran",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                  onChanged: (item) {
                    setState(() {
                      selectedPayment = item;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

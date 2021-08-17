import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/faq_model.dart';
import 'package:kampoeng_roti/providers/faq_provider.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class FaqBody extends StatefulWidget {
  @override
  _FaqBodyState createState() => _FaqBodyState();
}

class _FaqBodyState extends State<FaqBody> {
  Map<FaqModel, bool> expanded = {};
  @override
  Widget build(BuildContext context) {
    FaqProvider faqProvider = Provider.of<FaqProvider>(context);
    // faqProvider.getFaqs();
    // final List<FaqModel> faqList = faqProvider.faqs;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.0),
      child: FutureBuilder(
        future: faqProvider.getFaqs(),
        builder: (context, snapshot) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: faqProvider.faqs.length,
            itemBuilder: (BuildContext context, int index) {
              return faqModel(faqProvider.faqs[index]);
            },
          );
        },
      ),
    );
  }

  Card faqModel(FaqModel faqModel) {
    return Card(
      child: ExpansionTile(
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                text: faqModel.number.toString().padLeft(2, "0"),
                style: TextStyle(
                  color: choclateColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: "  " + faqModel.title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        children: <Widget>[
          ListTile(
            title: Text(
              faqModel.desc,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

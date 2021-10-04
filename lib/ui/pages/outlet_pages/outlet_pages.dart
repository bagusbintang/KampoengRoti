import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/providers/city_provider.dart';
import 'package:kampoeng_roti/providers/outlet_provider.dart';
import 'package:kampoeng_roti/ui/pages/outlet_pages/components/outlet_city.dart';
import 'package:kampoeng_roti/ui/pages/outlet_pages/components/outlet_header.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

// created by - Bagus *2021-04-07*

class OutletPages extends StatefulWidget {
  @override
  _OutletPagesState createState() => _OutletPagesState();
}

class _OutletPagesState extends State<OutletPages> {
  CityModel selectedCity;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    OutletProvider outletProvider = Provider.of<OutletProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // OutletsHeader(size: size),
            Container(
              height: size.height / 2.4,
              width: size.width,
              child: Stack(
                children: <Widget>[
                  OutletsHeader(size: size),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: softOrangeColor,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: Image(
                          image: AssetImage(
                            "assets/images/kr_logo.png",
                          ),
                          height: 150,
                          width: 150,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "OUTLET",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: choclateColor,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  textFieldSearchOutlets("Cari Outlets", Icon(Icons.search)),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            // Container(
            //   child: Column(
            //     children: <Widget>[
            //       Text(
            //         "Pilih Kota Anda",
            //         style: TextStyle(fontWeight: FontWeight.w700),
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Container(
            //         padding: const EdgeInsets.symmetric(horizontal: 15),
            //         decoration: BoxDecoration(
            //           color: softOrangeColor,
            //           borderRadius: BorderRadius.only(
            //             topLeft: const Radius.circular(15),
            //             topRight: const Radius.circular(15),
            //             bottomLeft: const Radius.circular(15),
            //             bottomRight: const Radius.circular(15),
            //           ),
            //         ),
            //         child: DropdownButtonHideUnderline(
            //           child: Theme(
            //             data: Theme.of(context).copyWith(
            //               canvasColor: softOrangeColor,
            //             ),
            //             child: FutureBuilder(
            //               future: cityProvider.getCity(),
            //               builder: (context, snapshot) {
            //                 return DropdownButton(
            //                   // value: selectedCity,
            //                   items: cityProvider.city.map((city) {
            //                     return DropdownMenuItem(
            //                       child: Text(city.cityName,
            //                           textAlign: TextAlign.center),
            //                       value: city,
            //                     );
            //                   }).toList(),
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontSize: 16,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                   iconEnabledColor: Colors.white,
            //                   hint: Container(
            //                     padding:
            //                         const EdgeInsets.symmetric(horizontal: 15),
            //                     child: Text(
            //                         selectedCity == null
            //                             ? "Surabaya"
            //                             : selectedCity.cityName,
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 16,
            //                             fontWeight: FontWeight.w700)),
            //                   ),
            //                   onChanged: (item) {
            //                     setState(() {
            //                       selectedCity = item;
            //                     });
            //                   },
            //                 );
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: FutureBuilder(
                future: outletProvider.getOutlets(
                    city_id: selectedCity == null ? 1 : selectedCity.id),
                builder: (context, snapshot) {
                  return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: outletProvider.outlets.length,
                    itemBuilder: (context, index) {
                      return OutletsCity(
                        size: size,
                        outletModel: outletProvider.outlets[index],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Theme textFieldSearchOutlets(String text, Icon icon) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.grey[400],
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(20.0),
              ),
            ),
            filled: true,
            hintStyle: new TextStyle(color: Colors.grey[400]),
            hintText: text,
            prefixIcon: icon,
            fillColor: Colors.white),
      ),
    );
  }
}

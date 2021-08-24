import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/providers/outlet_provider.dart';
import 'package:kampoeng_roti/ui/pages/home_pages/components/outlet_home_city.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class OutletHomePage extends StatefulWidget {
  const OutletHomePage({
    Key key,
    this.currentPosition,
  }) : super(key: key);
  final Position currentPosition;

  @override
  _OutletHomePageState createState() => _OutletHomePageState();
}

class _OutletHomePageState extends State<OutletHomePage> {
  // bool isVisible = false;
  City selectedCity;
  List<City> cityList = [
    City("Surabaya"),
    City("Sidoarjo"),
    City("Gresik"),
    City("Madura"),
    City("Malang"),
  ];
  List<DropdownMenuItem> generateCities(List<City> cityList) {
    List<DropdownMenuItem> items = [];
    for (var item in cityList) {
      items.add(
        DropdownMenuItem(
          child: Text(item.cityName, textAlign: TextAlign.center),
          value: item,
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    OutletProvider outletProvider = Provider.of<OutletProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "PILIH OUTLET",
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
        backgroundColor: softOrangeColor,
        elevation: 0.0,
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kr_background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Column(
                      children: [
                        Image(
                          image: AssetImage(
                            "assets/images/kr_logo.png",
                          ),
                          height: 150,
                          width: 150,
                        ),
                        textFieldSearchOutlets(
                            "Cari Outlets", Icon(Icons.search)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  selectCity(context),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: FutureBuilder(
                      future: outletProvider.getOutlets(),
                      builder: (context, snapshot) {
                        return ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: outletProvider.outlets.length,
                          itemBuilder: (context, index) {
                            return OutletsHomeCity(
                              size: size,
                              outletModel: outletProvider.outlets[index],
                              currentPosition: widget.currentPosition,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container selectCity(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Pilih Kota Anda",
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: softOrangeColor,
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
                  canvasColor: softOrangeColor,
                ),
                child: DropdownButton(
                  value: selectedCity,
                  items: generateCities(cityList),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  iconEnabledColor: Colors.white,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(cityList[0].cityName,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  onChanged: (item) {
                    setState(() {
                      // isVisible = true;
                      selectedCity = item;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
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
            contentPadding: EdgeInsets.zero,
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

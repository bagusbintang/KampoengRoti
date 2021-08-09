import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/ui/pages/outlet_pages/components/outlet_header.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';

// created by - Bagus *2021-04-07*

class OutletPages extends StatefulWidget {
  @override
  _OutletPagesState createState() => _OutletPagesState();
}

class _OutletPagesState extends State<OutletPages> {
  bool isVisible = false;
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            OutletsHeader(size: size),
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
                  textFieldSearchOutlets("Cari Outlets", Icon(Icons.search)),
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
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Visibility(
                      visible: isVisible,
                      child: OutletsCity(size: size),
                    );
                  }),
            ),
          ],
        ),
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
                    child: Text("Pilih Kota",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  onChanged: (item) {
                    setState(() {
                      isVisible = true;
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

class OutletsCity extends StatelessWidget {
  const OutletsCity({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[400]),
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          topRight: const Radius.circular(15),
          bottomLeft: const Radius.circular(15),
          bottomRight: const Radius.circular(15),
        ),
      ),
      child: Column(
        children: <Widget>[
          RawMaterialButton(
            onPressed: null,
            elevation: 2.0,
            fillColor: softOrangeColor,
            child: Icon(
              Icons.location_on_outlined,
              color: Colors.white,
            ),
            padding: EdgeInsets.zero,
            shape: CircleBorder(),
          ),
          Text(
            "Mulyosari".toUpperCase(),
            style: TextStyle(
              color: softOrangeColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Jl. Raya Mulyosari No.69D",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "Telp :" + "(031) 5998905",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            "LIHAT PETA --->",
            style: TextStyle(
              color: choclateColor,
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

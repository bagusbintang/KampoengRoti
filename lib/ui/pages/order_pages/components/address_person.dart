import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/models/province_models.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class AddressPerson extends StatefulWidget {
  const AddressPerson({Key key}) : super(key: key);

  @override
  _AddressPersonState createState() => _AddressPersonState();
}

class _AddressPersonState extends State<AddressPerson> {
  var data = Get.arguments;
  Province selectedProvince;
  City selectedCity;
  List<Province> provinceList = [
    Province("Jawa Timur"),
  ];
  List<City> cityList = [
    City("Surabaya"),
    City("Sidoarjo"),
    City("Gresik"),
    City("Madura"),
    City("Malang"),
  ];
  List<DropdownMenuItem> generateProvinces(List<Province> provinceList) {
    List<DropdownMenuItem> items = [];
    for (var item in provinceList) {
      items.add(
        DropdownMenuItem(
          child: Text(item.provinceName, textAlign: TextAlign.center),
          value: item,
        ),
      );
    }
    return items;
  }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ubah Alamat",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        leading: BackButton(
          color: Colors.black,
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[350],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              textFieldAddressName("Tag Alamat", initValue: data[0]),
              textFieldPersonName("Nama Penerima", initValue: data[1]),
              textFieldPersonPhone("Nomor Telpon", initValue: data[3]),
              textFieldAddress("Alamat", initValue: data[2]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Provinsi",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        selectProvince(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Kota",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        selectCity(context),
                      ],
                    ),
                  ),
                ],
              ),
              textFieldPersonPhone("Nomor Telpon", initValue: data[3]),
              GestureDetector(
                onTap: () {},
                child:
                    textFieldPinLocation("Pin Peta Lokasi", initValue: data[2]),
              ),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: "TAMBAH ALAMAT",
                press: () {
                  Get.back();
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container textFieldPinLocation(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              enabled: false,
              initialValue: initValue,
              keyboardType: TextInputType.name,
              maxLines: 4,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldAddressName(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              initialValue: initValue,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldPersonName(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              initialValue: initValue,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldPersonPhone(String title, {int initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              initialValue: initValue.toString(),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldAddress(String title, {String initValue}) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Theme(
            data: ThemeData(
              primaryColor: Colors.grey[300],
            ),
            child: TextFormField(
              initialValue: initValue,
              keyboardType: TextInputType.name,
              maxLines: 3,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(25),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(20.0),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  hintStyle: new TextStyle(color: Colors.grey[800]),
                  hintText: title,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container selectProvince(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
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
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButton(
                  value: selectedProvince,
                  items: generateProvinces(provinceList),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  iconEnabledColor: Colors.black,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Pilih Provinsi",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  onChanged: (item) {
                    setState(() {
                      selectedProvince = item;
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

  Container selectCity(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
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
                  canvasColor: Colors.grey[300],
                ),
                child: DropdownButton(
                  value: selectedCity,
                  items: generateCities(cityList),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                  iconEnabledColor: Colors.black,
                  hint: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text("Pilih Kota",
                        style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                  ),
                  onChanged: (item) {
                    setState(() {
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
}

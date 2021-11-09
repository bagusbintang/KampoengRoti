import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/models/province_models.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/city_provider.dart';
import 'package:kampoeng_roti/providers/province_provider.dart';
import 'package:kampoeng_roti/providers/user_address_provider.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/map_picker.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';

import '../../../shared_preferences.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({
    Key key,
  }) : super(key: key);

  @override
  _EditAddressState createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  TextEditingController tagNameController;
  TextEditingController personNameController;
  TextEditingController phoneController;
  TextEditingController addressController;
  TextEditingController addressDetailController;
  TextEditingController notesController;
  ProvinceModel selectedProvince;
  CityModel selectedCity;
  UserAddressModel userAddress = Get.arguments;
  UserModel userModel;
  // String provinceName;
  // String cityName;
  bool _checkBoxValue = false;

  void getUserModel() async {
    userModel = await MySharedPreferences.instance.getUserModel("user");
    // setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getUserModel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tagNameController.dispose();
    personNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    notesController.dispose();
  }

  void _checkBoxOnChange() {}

  @override
  Widget build(BuildContext context) {
    tagNameController = TextEditingController(text: userAddress.tagAddress);
    personNameController = TextEditingController(text: userAddress.personName);
    phoneController = TextEditingController(text: userAddress.personPhone);
    addressController = TextEditingController(text: userAddress.address);
    notesController = TextEditingController(text: userAddress.personName);
    addressDetailController =
        TextEditingController(text: userAddress.personPhone);

    // provinceName = userAddress.province;
    // cityName = userAddress.city;

    UserAddressProvider addressProvider =
        Provider.of<UserAddressProvider>(context);
    if (userAddress.defaultAddress == 1) {
      _checkBoxValue = true;
    }

    handleAddAddress() async {
      print(userAddress.latitude.toString());
      if (await addressProvider.editUserAddress(
        addressId: userAddress.id,
        tagAddress: tagNameController.text,
        personName: addressController.text,
        personPhone: notesController.text,
        address: addressController.text,
        province: userAddress.province,
        city: userAddress.city,
        latitude: userAddress.latitude,
        longitude: userAddress.longitude,
        defaultAddress: userAddress.defaultAddress,
      )) {
        if (_checkBoxValue) {
          userModel.defaulAdress = userAddress;
          MySharedPreferences.instance.setUserModel("user", userModel);
        }
        Get.off(DeliveryAddress());
        // Get.back();
      } else {
        // Get.snackbar(
        //   "Gagal Register",
        //   "User atau email sudah ada / kosong",
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: softOrangeColor,
        //   margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        // );
      }
    }

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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          // margin: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              textFieldAddressName(
                "Tag Alamat",
              ),
              GestureDetector(
                onTap: () async {
                  var result =
                      await Get.to(MapPicker(addressModel: userAddress));
                  setState(() {
                    userAddress = result;
                    addressController =
                        TextEditingController(text: userAddress.address);
                  });
                },
                child: textFieldPinLocation("Alamat",
                    initValue: userAddress.address),
              ),
              textFieldAddress(
                "Detil Alamat",
              ),
              textFieldNotes(
                "Catatan",
              ),
              Row(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 25,
                    height: 25,
                    child: Checkbox(
                      value: _checkBoxValue,
                      activeColor: Colors.grey[600],
                      onChanged: (bool newValue) {
                        setState(() {
                          _checkBoxValue = newValue;
                          if (newValue == true) {
                            userAddress.defaultAddress = 1;
                          } else {
                            userAddress.defaultAddress = 0;
                          }
                        });
                      },
                    ),
                  ),
                  Text(
                    "Jadikan Alamat Utama",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              // textFieldPersonName(
              //   "Nama Penerima",
              // ),
              // textFieldPersonPhone(
              //   "Nomor Telpon",
              // ),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: "UBAH ALAMAT",
                press: () {
                  handleAddAddress();
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
              // initialValue: initValue,
              controller: addressController,
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
              // initialValue: initValue,
              controller: tagNameController,
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
              // initialValue: initValue,
              controller: personNameController,
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
              // initialValue: initValue.toString(),
              controller: phoneController,
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
              // initialValue: initValue,
              controller: addressController,
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

  Container textFieldNotes(String title) {
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
              // initialValue: initValue,
              controller: notesController,
              keyboardType: TextInputType.text,
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

  // Row selectProvinceAndCity(BuildContext context,
  //     ProvinceProvider provinceProvider, CityProvider cityProvider) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Flexible(
  //         flex: 2,
  //         child: Container(
  //           margin: const EdgeInsets.only(top: 10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 "Provinsi",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //               Container(
  //                 child: Column(
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.symmetric(horizontal: 5),
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[300],
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: const Radius.circular(15),
  //                           topRight: const Radius.circular(15),
  //                           bottomLeft: const Radius.circular(15),
  //                           bottomRight: const Radius.circular(15),
  //                         ),
  //                       ),
  //                       child: DropdownButtonHideUnderline(
  //                         child: Theme(
  //                           data: Theme.of(context).copyWith(
  //                             canvasColor: Colors.grey[300],
  //                           ),
  //                           child: FutureBuilder(
  //                             future: provinceProvider.getProvinces(),
  //                             builder: (context, snapshot) {
  //                               return DropdownButton(
  //                                 // value: selectedProvince,
  //                                 items: provinceProvider.provinces
  //                                     .map((provinces) {
  //                                   return DropdownMenuItem(
  //                                     child: Text(provinces.provinceName,
  //                                         textAlign: TextAlign.start),
  //                                     value: provinces,
  //                                   );
  //                                 }).toList(),
  //                                 style: TextStyle(
  //                                   color: Colors.grey[500],
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                                 iconEnabledColor: Colors.black,
  //                                 hint: Container(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 12),
  //                                   child: Text(
  //                                       selectedProvince == null
  //                                           ? provinceProvider
  //                                                       .provinces.length ==
  //                                                   0
  //                                               ? ""
  //                                               : provinceName
  //                                           : selectedProvince.provinceName,
  //                                       style: TextStyle(
  //                                           color: Colors.grey[500],
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.w700)),
  //                                 ),
  //                                 onChanged: (item) {
  //                                   setState(() {
  //                                     selectedProvince = item;
  //                                     provinceName =
  //                                         selectedProvince.provinceName;
  //                                   });
  //                                 },
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       // SizedBox(
  //       //   width: 10,
  //       // ),
  //       Flexible(
  //         flex: 1,
  //         child: Container(
  //           margin: const EdgeInsets.only(top: 10),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: <Widget>[
  //               Text(
  //                 "Kota",
  //                 style: TextStyle(
  //                   color: Colors.black,
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 14,
  //                 ),
  //               ),
  //               Container(
  //                 child: Column(
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: 5,
  //                     ),
  //                     Container(
  //                       padding: const EdgeInsets.symmetric(horizontal: 5),
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[300],
  //                         borderRadius: BorderRadius.only(
  //                           topLeft: const Radius.circular(15),
  //                           topRight: const Radius.circular(15),
  //                           bottomLeft: const Radius.circular(15),
  //                           bottomRight: const Radius.circular(15),
  //                         ),
  //                       ),
  //                       child: DropdownButtonHideUnderline(
  //                         child: Theme(
  //                           data: Theme.of(context).copyWith(
  //                             canvasColor: Colors.grey[300],
  //                           ),
  //                           child: FutureBuilder(
  //                             future: cityProvider.getCity(
  //                                 provinceId: selectedProvince == null
  //                                     ? 11
  //                                     : selectedProvince.id),
  //                             builder: (context, snapshot) {
  //                               return DropdownButton(
  //                                 // value: selectedCity,
  //                                 items: cityProvider.city.map((city) {
  //                                   return DropdownMenuItem(
  //                                     child: Text(city.cityName,
  //                                         textAlign: TextAlign.center),
  //                                     value: city,
  //                                   );
  //                                 }).toList(),
  //                                 style: TextStyle(
  //                                   color: Colors.grey[500],
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                                 iconEnabledColor: Colors.black,
  //                                 hint: Container(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 12),
  //                                   child: Text(
  //                                       cityProvider.city.length == 0
  //                                           ? "Pilih Kota"
  //                                           : selectedCity == null
  //                                               ? cityName
  //                                               : selectedCity.cityName,
  //                                       style: TextStyle(
  //                                           color: Colors.grey[500],
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.w700)),
  //                                 ),
  //                                 onChanged: (item) {
  //                                   setState(() {
  //                                     selectedCity = item;
  //                                     cityName = selectedCity.cityName;
  //                                   });
  //                                 },
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}

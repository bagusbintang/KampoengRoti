import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:kampoeng_roti/models/city_models.dart';
import 'package:kampoeng_roti/models/province_models.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/models/user_model.dart';
import 'package:kampoeng_roti/providers/city_provider.dart';
import 'package:kampoeng_roti/providers/province_provider.dart';
import 'package:kampoeng_roti/providers/user_address_provider.dart';
import 'package:kampoeng_roti/shared_preferences.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/delivery_address.dart';
import 'package:kampoeng_roti/ui/pages/address_pages/map_picker.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({
    Key key,
  }) : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  // static final kInitialPosition = LatLng(-33.8567844, 151.213108);
  TextEditingController tagNameController = TextEditingController(text: '');
  TextEditingController personNameController = TextEditingController(text: '');
  TextEditingController phoneController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController addressDetailController =
      TextEditingController(text: '');
  TextEditingController notesController = TextEditingController(text: '');

  UserModel userModel = Get.arguments;
  UserAddressModel userAddressModel = UserAddressModel();
  ProvinceModel selectedProvince;
  CityModel selectedCity;
  bool _checkBoxValue = false;

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
    const kGoogleApiKey = "AIzaSyDFo_3wbFmTfFHuaivN56QOyupSdnkSeis";

    GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

    UserAddressProvider addressProvider =
        Provider.of<UserAddressProvider>(context);

    handleAddAddress() async {
      if (await addressProvider.addUserAddress(
        userId: userModel.id,
        tagAddress: tagNameController.text,
        personName: addressDetailController.text,
        personPhone: notesController.text,
        address: addressController.text,
        province: userAddressModel.province,
        city: userAddressModel.city,
        latitude: userAddressModel.latitude,
        longitude: userAddressModel.longitude,
        defaultAddress: userAddressModel.defaultAddress,
      )) {
        if (_checkBoxValue) {
          userModel.defaulAdress = userAddressModel;
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

    Future<Null> displayPrediction(Prediction p) async {
      if (p != null) {
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
        var placeId = p.placeId;
        double lat = detail.result.geometry.location.lat;
        double lng = detail.result.geometry.location.lng;

        var address =
            await Geocoder.local.findAddressesFromQuery(p.description);

        print(lat);
        print(lng);
      }
    }

    // ProvinceProvider provinceProvider = Provider.of<ProvinceProvider>(context);
    // CityProvider cityProvider = Provider.of<CityProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Alamat",
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
                      await Get.to(MapPicker(addressModel: userAddressModel));
                  setState(() {
                    userAddressModel = result;
                    addressController =
                        TextEditingController(text: userAddressModel.address);
                  });

                  // Prediction p = await PlacesAutocomplete.show(
                  //   context: context,
                  //   apiKey: kGoogleApiKey,
                  //   mode: Mode.overlay,
                  // );
                  // displayPrediction(p);
                },
                child: textFieldPinLocation(
                  "Alamat",
                ),
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
                            userAddressModel.defaultAddress = 1;
                          } else {
                            userAddressModel.defaultAddress = 0;
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

              // selectProvinceAndCity(context, provinceProvider, cityProvider),
              SizedBox(
                height: 30,
              ),
              DefaultButton(
                text: "TAMBAH ALAMAT",
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

  Container textFieldPinLocation(String title) {
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
                  hintText: userModel.defaulAdress.address == null
                      ? title
                      : userModel.defaulAdress.address,
                  fillColor: Colors.grey[300]),
            ),
          )
        ],
      ),
    );
  }

  Container textFieldAddressName(String title) {
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

  Container textFieldPersonName(String title) {
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

  Container textFieldPersonPhone(String title) {
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

  Container textFieldAddress(String title) {
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
              controller: addressDetailController,
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
  //                                     child: Text(
  //                                       provinces.provinceName,
  //                                       textAlign: TextAlign.start,
  //                                     ),
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
  //                                               ? "Province Kosong"
  //                                               : "Pilih Provinsi"
  //                                           : selectedProvince.provinceName,
  //                                       style: TextStyle(
  //                                           color: Colors.grey[500],
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.w700)),
  //                                 ),
  //                                 onChanged: (item) {
  //                                   setState(() {
  //                                     selectedProvince = item;
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
  //                                               ? "Pilih Kota"
  //                                               : selectedCity.cityName,
  //                                       style: TextStyle(
  //                                           color: Colors.grey[500],
  //                                           fontSize: 14,
  //                                           fontWeight: FontWeight.w700)),
  //                                 ),
  //                                 onChanged: (item) {
  //                                   setState(() {
  //                                     selectedCity = item;
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

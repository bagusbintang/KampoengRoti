import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/ui/theme/theme.dart';
import 'package:kampoeng_roti/ui/widgets/default_button.dart';

class MapPicker extends StatefulWidget {
  const MapPicker({
    Key key,
    this.addressModel,
  }) : super(key: key);
  final UserAddressModel addressModel;

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  List<Placemark> _placemarks;
  Set<Marker> _markers = {};
  LatLng _currentPosition;
  LatLng _changePosition;
  String _address;
  double _latitude;
  double _longitude;
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();

  GoogleMapController _controller;

  @override
  void initState() {
    if (mounted) {
      _getCurrentLocation();
    }
    super.initState();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
              target: LatLng(position.latitude, position.longitude), zoom: 18),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId('current_location'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {
        _getPlace(_currentPosition);
        // _markers.clear();
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _getPlace(LatLng latLng) async {
    _placemarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

    Placemark placemark = _placemarks[0];
    _address = "${placemark.street}, " + //nama jalan
        "${placemark.subLocality}, " + //nama sektor
        "${placemark.locality}, " + //nama kecamatan
        "${placemark.subAdministrativeArea}, " + //nama kota
        "${placemark.administrativeArea}, "; // nama provinsi
    _latitude = latLng.latitude;
    _longitude = latLng.longitude;
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        if (widget.addressModel.latitude != null &&
            widget.addressModel.longitude != null) {
          _currentPosition = LatLng(
            widget.addressModel.latitude,
            widget.addressModel.latitude,
          );
        } else {
          _currentPosition = LatLng(position.latitude, position.longitude);
        }
        print("lat : " +
            position.latitude.toString() +
            "long : " +
            position.longitude.toString());
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: mapWidget(size),
      ),
    );
  }

  Widget mapWidget(Size size) {
    return FutureBuilder(
      future: _getCurrentLocation(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.waiting) {
          return Container();
        } else {
          return _currentPosition == null
              ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Center(
                      child: Text(
                    "Menunggu mendapatkan lokasi saat ini...",
                    style: TextStyle(
                      color: choclateColor,
                      fontSize: 24,
                    ),
                  )),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition,
                        zoom: 18.0,
                      ),
                      markers: _markers,
                      onCameraMove: (CameraPosition position) {
                        _markers.clear();

                        _changePosition = LatLng(
                          position.target.latitude,
                          position.target.longitude,
                        );
                        _getPlace(_changePosition);
                        _markers.add(
                          Marker(
                            markerId: MarkerId('current_location'),
                            position: _changePosition,
                            icon: BitmapDescriptor.defaultMarker,
                          ),
                        );
                        setState(() {});
                      },
                      onMapCreated: _onMapCreated,
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: size.height / 4.5,
                        width: size.width,
                        color: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Column(
                          children: [
                            Spacer(),
                            Text(
                              _address == null ? "" : _address,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: choclateColor,
                                fontSize: 16,
                              ),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text(
                            //     _latitude.toString() + " - " + _longitude.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Spacer(),
                            DefaultButton(
                              text: "Pilih Lokasi",
                              press: () {
                                widget.addressModel.address = _address;
                                widget.addressModel.latitude = _latitude;
                                widget.addressModel.longitude = _longitude;
                                Get.back(result: widget.addressModel);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

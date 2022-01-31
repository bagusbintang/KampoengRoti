import 'package:flutter/material.dart';
import 'package:kampoeng_roti/models/user_address_model.dart';
import 'package:kampoeng_roti/services/user_address_service.dart';

class UserAddressProvider with ChangeNotifier {
  UserAddressModel _userAddressModel;
  List<UserAddressModel> _userAddress = [];

  UserAddressModel get userAddressModel => _userAddressModel;

  set userAddressModel(UserAddressModel userAddressModel) {
    _userAddressModel = userAddressModel;
    notifyListeners();
  }

  List<UserAddressModel> get userAddress => _userAddress;

  set userAddress(List<UserAddressModel> address) {
    _userAddress = address;
    notifyListeners();
  }

  Future<void> getUserAddress({
    int userId,
  }) async {
    try {
      _userAddress.clear();
      List<UserAddressModel> address =
          await UserAddressService().getAddress(userId: userId);
      _userAddress = address;
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addUserAddress({
    int userId,
    String tagAddress,
    String personName,
    String personPhone,
    String address,
    String city,
    String province,
    String notes,
    double latitude,
    double longitude,
    int defaultAddress,
  }) async {
    try {
      UserAddressModel userAddressModel =
          await UserAddressService().addUserAddress(
        userId: userId,
        tagAddress: tagAddress,
        personName: personName,
        personPhone: personPhone,
        address: address,
        city: city,
        province: province,
        notes: notes,
        latitude: latitude,
        longitude: longitude,
        defaultAddress: defaultAddress,
      );

      _userAddressModel = userAddressModel;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editUserAddress({
    int addressId,
    String tagAddress,
    String personName,
    String personPhone,
    String address,
    String city,
    String province,
    String notes,
    double latitude,
    double longitude,
    int defaultAddress,
  }) async {
    try {
      UserAddressModel userAddressModel =
          await UserAddressService().editUserAddress(
        addressId: addressId,
        tagAddress: tagAddress,
        personName: personName,
        personPhone: personPhone,
        address: address,
        city: city,
        province: province,
        notes: notes,
        latitude: latitude,
        longitude: longitude,
        defaultAddress: defaultAddress,
      );

      _userAddressModel = userAddressModel;

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

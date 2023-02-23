import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/user_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/firebase_constants.dart';
import 'package:medihelp/utils/shared_preference.dart';

import '../../../utils/shared_preference_keys.dart';

class ProfileController extends GetxController {
  UserModel? myProfileData;
  bool loadingLocation = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  Future<void> getProfileData(context) async {
    final String myUserId = await SharedPref.read(prefKeyUserId) ?? "";
    try {
      myProfileData = await getUserData(myUserId);
      update();
    } catch (e) {
      throw e;
    }
  }

  setLocationText(context) {
    final String myAddress = myProfileData?.address ?? "";
    if (myAddress.isEmpty) {
      getCurrentPosition(context);
    } else {
      addressController.text = myAddress;
      loadingLocation = false;
    }
    update();
  }

  Future<void> updateProfile({
    required String name,
    required String email,
    required String address,
  }) async {
    if (myProfileData != null) {
      showLoaderAlert();
      myProfileData?.name = name;
      myProfileData?.email = email;
      myProfileData?.address = address;
      myProfileData?.latitude =
          currentPosition == null ? "" : currentPosition!.latitude.toString();
      myProfileData?.longitude =
          currentPosition == null ? "" : currentPosition!.longitude.toString();

      await FirebaseFirestore.instance
          .collection(TableUsers.collectionName)
          .doc(myProfileData?.userId)
          .update(myProfileData!.toJson());
    }

    Get.back();
    update();
    snackBarWidget(title: "Profile has been updated", subTitle: "");
  }

  Position? currentPosition;

  Future<void> getCurrentPosition(context) async {
    loadingLocation = true;
    bool hasMapPermission = await checkMapPermission(context);
    if (hasMapPermission) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        currentPosition = position;

        await placemarkFromCoordinates(
                currentPosition!.latitude, currentPosition!.longitude)
            .then((List<Placemark> placemarks) {
          Placemark place = placemarks[0];
          addressController.text =
              '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
        });
        loadingLocation = false;
        update();
      } catch (e) {
        loadingLocation = false;
        update();
        throw e;
      }
    } else {
      loadingLocation = false;
      update();
    }
  }
}

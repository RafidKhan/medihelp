import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/user_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/firebase_constants.dart';
import 'package:medihelp/utils/shared_preference.dart';

import '../../../utils/shared_preference_keys.dart';

class ProfileController extends GetxController {
  UserModel? myProfileData;
  bool isEditProfileVisible = false;

  Future<void> getProfileData() async {
    final String myUserId = await SharedPref.read(prefKeyUserId) ?? "";
    if (myUserId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection(TableUsers.collectionName)
          .doc(myUserId)
          .get()
          .then((value) {
        if (value.data() != null) {
          myProfileData = UserModel.fromJson(value.data()!);
        }
      });
    }

    update();
  }

  toggleEditProfileVisibility() {
    isEditProfileVisible = !isEditProfileVisible;
    update();
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String address,
  }) async {
    print("NAME: ${name}");
    print("PHONE: ${phone}");
    print("ADDRESS: ${address}");
    // showLoaderAlert();
    // await Future.delayed(Duration(seconds: 2));
    // Get.back();
  }
}

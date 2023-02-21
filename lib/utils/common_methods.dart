import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/modules/authentication/login/view/login_view.dart';
import 'package:medihelp/utils/firebase_constants.dart';
import 'package:medihelp/utils/shared_preference.dart';
import 'package:medihelp/utils/styles.dart';
import 'package:permission_handler/permission_handler.dart';

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<bool> checkMapPermission(context) async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location services are disabled. Please enable the services')));
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')));
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.')));
    return false;
  }
  return true;
}

final ImagePicker _picker = ImagePicker();

Future<String> cameraOrGalleryImage(bool isGallery) async {
  String path = "";
  try {
    late ImageSource imageSource;

    if (isGallery) {
      imageSource = ImageSource.gallery;
    } else {
      imageSource = ImageSource.camera;
    }

    if (isGallery) {
      if (await Permission.storage.request().isGranted) {
        final captureFile = await _picker.pickImage(source: imageSource);

        path = captureFile?.path ?? "";
      }
    } else {
      if (await Permission.camera.request().isGranted) {
        final captureFile = await _picker.pickImage(source: imageSource);

        path = captureFile?.path ?? "";
      }
    }
  } catch (e) {
    path = "";
    snackBarWidget(title: "Something went wrong", subTitle: "");
  }

  return path;
}

Future<String> getUserProfileImageUrl({required userId}) async {
  var url = "";

  try {
    var ref = FirebaseStorage.instance
        .ref()
        .child("${StoragePath.USER_PROFILE_IMAGE_PATH}${userId}.jpg");

    url = (await ref.getDownloadURL()).toString();
  } catch (e) {
    url = "";
  }
  return url;
}

snackBarWidget(
    {required String title, required String subTitle, Color? color}) {
  Get.snackbar(
    title,
    subTitle,
    backgroundColor: color ?? Colors.white,
  );
}

int multiplyStrings(List<String> strings) {
  int result = 1;
  for (int i = 0; i < strings.length; i++) {
    final convertToInt = int.parse(strings[i]);
    result = result * convertToInt;
  }

  return result;
}

showLoaderAlert() {
  Get.dialog(AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LoaderWidget(),
      ],
    ),
  ));
}

logoutUser() async {
  showLoaderAlert();
  await FirebaseAuth.instance.signOut();
  await SharedPref.removeAll();
  Get.back();
  Get.off(
    () => const LoginView(),
    transition: defaultPageTransition,
  );
}

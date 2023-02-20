import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/user_model.dart';
import 'package:medihelp/modules/authentication/login/view/login_view.dart';
import 'package:medihelp/modules/authentication/profile_setup/view/profile_setup.dart';
import 'package:medihelp/modules/bottom_nav_page/view/bottom_nav_page.dart';
import 'package:medihelp/modules/dashboard/view/dashboard_view.dart';
import 'package:medihelp/utils/firebase_constants.dart';
import 'package:medihelp/utils/styles.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../utils/common_methods.dart';

class AuthController extends GetxController {
  final loginPhoneNumber = Rxn<String?>();
  final otpValue = Rxn<String?>();

  final regPhoneNumber = Rxn<String?>();
  final regOtp = Rxn<String?>();

  final profileSetupName = Rxn<String?>();
  final profileSetupEmail = Rxn<String?>();
  final profileSetupImageFilePath = Rxn<String?>();

  RxBool verifyButtonLoading = false.obs;
  RxBool registerButtonLoading = false.obs;

  String verificationIDPhoneSignIn = "";

  String verificationIDPhoneSignUp = "";

  Future<void> getLoginOtp() async {
    final phoneNumber = "+88${loginPhoneNumber.value}";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        snackBarWidget(
            title: "Something went wrong", subTitle: e.message ?? "");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIDPhoneSignIn = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIDPhoneSignIn = verificationId;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  Future<void> getSignupOtp() async {
    final phoneNumber = "+88${regPhoneNumber.value}";
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException e) {
        snackBarWidget(
            title: "Something went wrong", subTitle: e.message ?? "");
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIDPhoneSignUp = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIDPhoneSignUp = verificationId;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  Future<void> verifyPhoneLogin() async {
    try {
      verifyButtonLoading.value = true;
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationIDPhoneSignIn,
            smsCode: otpValue.value ?? ""),
      )
          .then((value) async {
        if (value.user != null) {
          var userId = value.user?.uid;

          await FirebaseFirestore.instance
              .collection(TableUsers.collectionName)
              .doc(userId)
              .get()
              .then((value) {
            if (value.data() == null) {
              verifyButtonLoading.value = false;
              snackBarWidget(
                  title: "Registration Required",
                  subTitle:
                      "You must register first, before you could use your phone number for sign in");
            } else {
              verifyButtonLoading.value = false;

              Get.off(() => const BottomNavScreen(),
                  transition: defaultPageTransition);
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: e.message ?? "");
    } catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: "");
    }
  }

  Future<void> verifyPhoneSignUp() async {
    try {
      verifyButtonLoading.value = true;
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationIDPhoneSignUp,
            smsCode: otpValue.value ?? ""),
      )
          .then((value) async {
        if (value.user != null) {
          var userId = value.user?.uid;

          await FirebaseFirestore.instance
              .collection(TableUsers.collectionName)
              .doc(userId)
              .get()
              .then((value) {
            if (value.data() == null) {
              verifyButtonLoading.value = false;
              Get.to(
                () => const ProfileSetupView(),
                transition: defaultPageTransition,
              );
            } else {
              verifyButtonLoading.value = false;
              snackBarWidget(
                  title: "You are already registered",
                  subTitle: "Please login to access medihelp");
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: e.message ?? "");
    } catch (e) {
      verifyButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: "");
    }
  }

  Future<void> performSignUp() async {
    registerButtonLoading.value = true;
    try {
      UserModel userModel = UserModel();

      final userId = FirebaseAuth.instance.currentUser?.uid;
      userModel.userId = userId;
      userModel.name = profileSetupName.value;
      userModel.email = profileSetupEmail.value;
      userModel.phoneNumber = regPhoneNumber.value;

      File imageFileProfile = File(profileSetupImageFilePath.value!);

      await FirebaseStorage.instance
          .ref()
          .child("${StoragePath.USER_PROFILE_IMAGE_PATH}${userId}.jpg")
          .putFile(imageFileProfile);
      userModel.profilePicture = await getUserProfileImageUrl(userId: userId);
      await FirebaseFirestore.instance
          .collection(TableUsers.collectionName)
          .doc(userId)
          .set(userModel.toJson());
      registerButtonLoading.value = false;

      snackBarWidget(
          title: "Registration successful",
          subTitle: "Please login to continue");
      Get.off(
        () => const LoginView(),
        transition: defaultPageTransition,
      );
    } catch (e) {
      registerButtonLoading.value = false;
      snackBarWidget(title: "Something went wrong", subTitle: "");
    }
  }
}

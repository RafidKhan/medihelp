import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medihelp/utils/firebase_constants.dart';
import 'package:medihelp/utils/styles.dart';

class LoginController extends GetxController {
  final loginPhoneNumber = Rxn<String?>();
  final loginOtp = Rxn<String?>();
  RxBool verifyButtonLoading = false.obs;

  String verificationIDPhoneSignIn = "";
  int resend_TokenPhoneSignIn = 0;

  getLoginOtp() async {
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
        if (resendToken != null) {
          resend_TokenPhoneSignIn = resendToken;
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationIDPhoneSignIn = verificationId;
      },
      timeout: const Duration(seconds: 120),
    );
  }

  Future<void> verifyPhoneLogin() async {
    try {
      verifyButtonLoading.value = true;
      print("DATA: ${verificationIDPhoneSignIn}");
      print("DATA: ${loginOtp.value}");
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationIDPhoneSignIn,
            smsCode: loginOtp.value ?? ""),
      )
          .then((value) async {
        if (value.user != null) {
          var userId = value.user?.uid;

          await FirebaseFirestore.instance
              .collection(TableUsers.TABLE_USERS)
              .where(TableUsers.TABLE_USERS_ID, isEqualTo: userId)
              .get()
              .then((value) {
            if (value.docs.isEmpty) {
              verifyButtonLoading.value = false;
              snackBarWidget(
                  title: "Registration Required",
                  subTitle:
                      "You must register first, before you could use your phone number for sign in");
            } else {
              verifyButtonLoading.value = false;
              // generalLoginMethod(
              //     userId: "$userId", loginType: LOGIN_TYPE_PHONE);
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
      throw e;
    }
  }
}

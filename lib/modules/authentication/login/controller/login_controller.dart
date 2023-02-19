import 'package:get/get.dart';

class LoginController extends GetxController {
  final loginPhoneNumber = Rxn<String?>();

  sendOtp() {
    print("NUMBER: ${loginPhoneNumber}");
  }
}

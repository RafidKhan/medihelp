import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/base/base_state.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/authentication/controller/auth_controller.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends BaseState<OtpView> {
  final authController = Get.put(AuthController());

  late Rxn<String?> otpValue;
  TextEditingController otpController = TextEditingController();
  var arguments;
  late bool isLoginOperation;

  @override
  void initState() {
    // TODO: implement initState
    arguments = Get.arguments;
    if (arguments == 'login-screen') {
      authController.getLoginOtp();
      isLoginOperation = true;
    } else if (arguments == 'reg-screen') {
      authController.getSignupOtp();
      isLoginOperation = false;
    }
    otpValue = authController.otpValue;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetGetXValues([otpValue]);
    otpController.dispose();
    closeSoftKeyBoard();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return DefaultScaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            physics: bouncingPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                TextComponent(
                  isLoginOperation == true ? "Login" : "Register",
                  fontSize: fontSize22,
                  fontWeight: fontWeight700,
                  padding: const EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                const TextComponent(
                  "Enter OTP",
                  fontSize: fontSize18,
                  fontWeight: fontWeight500,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                TextFieldComponent(
                  controller: otpController,
                  hintText: "otp",
                  keyboardType: TextInputType.phone,
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                  onChanged: (value) {
                    otpValue.value = value;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (value.length > 6 || value.length < 6) {
                        return "OTP should be 6 digits long";
                      }
                    }
                    return null;
                  },
                ),
                Obx(
                  () => CommonButton(
                    btnText: isLoginOperation == true ? "Login" : "Continue",
                    isEnabled: !isBlank([otpValue]),
                    isLoading: controller.verifyButtonLoading.value,
                    margin: const EdgeInsets.symmetric(
                      horizontal: horizontalMargin,
                      vertical: float10,
                    ),
                    onTap: () {
                      closeSoftKeyBoard();
                      if (isLoginOperation == true) {
                        controller.verifyPhoneLogin();
                      } else if (isLoginOperation == false) {
                        controller.verifyPhoneSignUp();
                      }
                    },
                  ),
                )
              ],
            ),
          ));
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/base/base_state.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/authentication/controller/auth_controller.dart';
import 'package:medihelp/modules/authentication/login/view/otp_view.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends BaseState<RegistrationView> {
  final authController = Get.put(AuthController());

  late Rxn<String?> regPhoneNumber;
  TextEditingController phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    regPhoneNumber = authController.regPhoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              const TextComponent(
                "Register",
                fontSize: fontSize22,
                fontWeight: fontWeight700,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float10,
                ),
              ),
              const TextComponent(
                "Enter Phone Number",
                fontSize: fontSize18,
                fontWeight: fontWeight500,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float10,
                ),
              ),
              TextFieldComponent(
                controller: phoneController,
                hintText: "Phone number",
                keyboardType: TextInputType.phone,
                margin: const EdgeInsets.only(
                  left: horizontalMargin,
                  right: horizontalMargin,
                  bottom: float10,
                ),
                onChanged: (value) {
                  regPhoneNumber.value = value;
                },
              ),
              Obx(
                () => CommonButton(
                  btnText: "Send OTP",
                  isEnabled: !isBlank([regPhoneNumber]),
                  margin: const EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                  onTap: () {
                    closeSoftKeyBoard();
                    Get.to(
                      () => const OtpView(),
                      transition: defaultPageTransition,
                      arguments: 'reg-screen',
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextComponent(
                      "Already have account? ",
                      fontSize: fontSize14,
                      fontWeight: fontWeight400,
                    ),
                    TextComponent(
                      "login",
                      fontSize: fontSize14,
                      fontWeight: fontWeight500,
                      color: kSecondaryColor,
                      textDecoration: TextDecoration.underline,
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

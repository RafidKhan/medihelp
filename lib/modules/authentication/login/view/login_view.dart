import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/authentication/login/controller/login_controller.dart';
import 'package:medihelp/utils/styles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
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
                  "Login",
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
                  hintText: "Phone Number",
                  keyboardType: TextInputType.phone,
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                ),
                CommonButton(
                  btnText: "Send OTP",
                  margin: const EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                )
              ],
            ),
          ));
    });
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/base/base_state.dart';
import 'package:medihelp/components/adatptive_button.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/modules/authentication/controller/auth_controller.dart';
import 'package:medihelp/modules/authentication/login/view/otp_view.dart';
import 'package:medihelp/modules/authentication/registration/registration_view.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

class ProfileSetupView extends StatefulWidget {
  const ProfileSetupView({Key? key}) : super(key: key);

  @override
  State<ProfileSetupView> createState() => _ProfileSetupViewState();
}

class _ProfileSetupViewState extends BaseState<ProfileSetupView> {
  final authController = Get.put(AuthController());

  late Rxn<String?> profileSetupName,
      profileSetupEmail,
      profileSetupImageFilePath;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    profileSetupName = authController.profileSetupName;
    profileSetupEmail = authController.profileSetupEmail;
    profileSetupImageFilePath = authController.profileSetupImageFilePath;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetGetXValues(
        [profileSetupName, profileSetupEmail, profileSetupImageFilePath]);
    nameController.dispose();
    emailController.dispose();
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
                const TextComponent(
                  "Setup your profile",
                  fontSize: fontSize22,
                  fontWeight: fontWeight700,
                  padding: EdgeInsets.symmetric(
                    horizontal: horizontalMargin,
                    vertical: float10,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: float36),
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: kFadedTextColor,
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Center(
                          child: Obx(
                            () => profileSetupImageFilePath.value == null
                                ? Image.asset(
                                    Assets.icons.user.path,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                    color: kFadedTextColor,
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(40.0),
                                    child: FadeInImage(
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                      placeholder: AssetImage(
                                          Assets.images.transparentBg.path),
                                      image: FileImage(File(
                                          profileSetupImageFilePath.value!)),
                                    ),
                                  ),
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final bool? isGallery =
                                await Get.dialog(AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const TextComponent(
                                    "Select one",
                                    fontSize: fontSize16,
                                    fontWeight: fontWeight400,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: horizontalMargin,
                                      vertical: float10,
                                    ),
                                  ),
                                  AdaptiveButton(
                                      btnText: 'Gallery',
                                      onTap: () {
                                        Get.back(result: true);
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  AdaptiveButton(
                                      btnText: 'Camera',
                                      onTap: () {
                                        Get.back(result: false);
                                      }),
                                ],
                              ),
                            ));
                            if (isGallery != null) {
                              final String path =
                                  await cameraOrGalleryImage(isGallery);
                              if (path.isNotEmpty) {
                                profileSetupImageFilePath.value = path;
                              } else {
                                profileSetupImageFilePath.value = null;
                              }
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.all(
                                float5,
                              ),
                              decoration: const BoxDecoration(
                                color: kSecondaryColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.upload,
                                size: float16,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
                TextFieldComponent(
                  controller: nameController,
                  hintText: "Name",
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                  onChanged: (value) {
                    profileSetupName.value = value;
                  },
                ),
                TextFieldComponent(
                  controller: emailController,
                  hintText: "Email",
                  keyboardType: TextInputType.emailAddress,
                  margin: const EdgeInsets.only(
                    left: horizontalMargin,
                    right: horizontalMargin,
                    bottom: float10,
                  ),
                  onChanged: (value) {
                    profileSetupEmail.value = value;
                  },
                  validator: (value) {
                    if (value != null) {
                      if (!value.isEmail) {
                        return "Please enter a valid email";
                      }
                    }
                    return null;
                  },
                ),
                Obx(
                  () => CommonButton(
                    btnText: "Register",
                    isLoading: controller.registerButtonLoading.value,
                    isEnabled: !isBlank([
                      profileSetupName,
                      profileSetupEmail,
                      profileSetupImageFilePath
                    ]),
                    margin: const EdgeInsets.symmetric(
                      horizontal: horizontalMargin,
                      vertical: float10,
                    ),
                    onTap: () {
                      closeSoftKeyBoard();
                      controller.performSignUp();
                    },
                  ),
                ),
              ],
            ),
          ));
    });
  }
}

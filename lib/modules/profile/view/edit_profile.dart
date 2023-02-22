import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/profile/controller/profile_controller.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';
import 'package:medihelp/components/app_bar_widget.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/loader_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      profileController.nameController.text =
          profileController.myProfileData!.name ?? "";
      profileController.emailController.text =
          profileController.myProfileData!.email ?? "";
      profileController.setLocationText(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return DefaultScaffold(
          appBar: const AppbarWidget(
            title: 'Profile',
            hideBackButton: true,
          ),
          body: controller.myProfileData == null &&
                  controller.loadingLocation == true
              ? LoaderWidget()
              : SingleChildScrollView(
                  physics: bouncingPhysics,
                  child: Column(
                    children: [
                      TextFieldComponent(
                        controller: profileController.nameController,
                        hintText: "Name",
                        margin: const EdgeInsets.symmetric(
                          vertical: float10,
                          horizontal: horizontalMargin,
                        ),
                      ),
                      TextFieldComponent(
                        controller: profileController.emailController,
                        hintText: "Email",
                        margin: const EdgeInsets.symmetric(
                          vertical: float10,
                          horizontal: horizontalMargin,
                        ),
                        onChanged: (value) {
                          setState(() {});
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
                      TextFieldComponent(
                        controller: profileController.addressController,
                        hintText: "Address",
                        suffix: InkWell(
                          onTap: () {
                            controller.getCurrentPosition(context);
                          },
                          child: const Icon(Icons.location_on_outlined),
                        ),
                        margin: const EdgeInsets.symmetric(
                          vertical: float10,
                          horizontal: horizontalMargin,
                        ),
                      ),
                      CommonButton(
                        btnText: "Update",
                        isEnabled:
                            profileController.emailController.text.isEmail,
                        margin: const EdgeInsets.symmetric(
                          horizontal: horizontalMargin,
                          vertical: float10,
                        ),
                        onTap: () async {
                          closeSoftKeyBoard();
                          controller.updateProfile(
                            name: profileController.nameController.text.trim(),
                            email:
                                profileController.emailController.text.trim(),
                            address:
                                profileController.addressController.text.trim(),
                          );
                        },
                      )
                    ],
                  ),
                ));
    });
  }
}

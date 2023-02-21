import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/profile/controller/profile_controller.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

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
    profileController.nameController.text =
        profileController.myProfileData!.name ?? "";
    profileController.phoneController.text =
        profileController.myProfileData!.phoneNumber ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    profileController.nameController.dispose();
    profileController.phoneController.dispose();
    profileController.addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Visibility(
          visible: controller.isEditProfileVisible,
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
                controller: profileController.phoneController,
                hintText: "Phone number",
                margin: const EdgeInsets.symmetric(
                  vertical: float10,
                  horizontal: horizontalMargin,
                ),
              ),
              TextFieldComponent(
                controller: profileController.addressController,
                hintText: "Address",
                enabled: false,
                margin: const EdgeInsets.symmetric(
                  vertical: float10,
                  horizontal: horizontalMargin,
                ),
                onTap: () async {},
              ),
              CommonButton(
                btnText: "Update",
                margin: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float10,
                ),
                onTap: () async {
                  controller.updateProfile(
                    name: profileController.nameController.text.trim(),
                    phone: profileController.phoneController.text.trim(),
                    address: profileController.addressController.text.trim(),
                  );
                },
              )
            ],
          ));
    });
  }
}

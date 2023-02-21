import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/common_button.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/profile/controller/profile_controller.dart';
import 'package:medihelp/utils/styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profileController = Get.put(ProfileController());
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = profileController.myProfileData!.name ?? "";
    phoneController.text = profileController.myProfileData!.phoneNumber ?? "";
    addressController.text = profileController.myProfileData!.address ?? "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
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
                controller: nameController,
                hintText: "Name",
                margin: const EdgeInsets.symmetric(
                  vertical: float10,
                  horizontal: horizontalMargin,
                ),
              ),
              TextFieldComponent(
                controller: phoneController,
                hintText: "Phone number",
                margin: const EdgeInsets.symmetric(
                  vertical: float10,
                  horizontal: horizontalMargin,
                ),
              ),
              TextFieldComponent(
                controller: addressController,
                hintText: "Address",
                enabled: false,
                margin: const EdgeInsets.symmetric(
                  vertical: float10,
                  horizontal: horizontalMargin,
                ),
              ),
              CommonButton(
                btnText: "Update",
                margin: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float10,
                ),
                onTap: () async {
                  controller.updateProfile(
                    name: nameController.text.trim(),
                    phone: phoneController.text.trim(),
                    address: addressController.text.trim(),
                  );
                },
              )
            ],
          ));
    });
  }
}

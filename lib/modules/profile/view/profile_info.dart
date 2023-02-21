import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/modules/profile/controller/profile_controller.dart';
import 'package:medihelp/utils/styles.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (controller) {
      return Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.only(
                top: float24,
                bottom: float12,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: CachedNetworkImage(
                  progressIndicatorBuilder: (context, url, progress) => Center(
                    child: LoaderWidget(
                      size: 10,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Image.asset(
                      Assets.logo.appLogo.path,
                      height: 100,
                      width: 100,
                    );
                  },
                  imageUrl: controller.myProfileData?.profilePicture ?? "",
                  height: 100,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          TextComponent(
            controller.myProfileData?.name ?? "Name not Found",
            fontSize: fontSize18,
            fontWeight: fontWeight600,
            color: kSecondaryColor,
            padding: const EdgeInsets.only(
              bottom: float10,
            ),
          ),
          TextComponent(
            controller.myProfileData?.email ?? "Email not found",
            fontSize: fontSize16,
            fontWeight: fontWeight400,
            padding: const EdgeInsets.only(
              bottom: float10,
            ),
          ),
          TextComponent(
            controller.myProfileData?.phoneNumber ?? "Phone number not found",
            fontSize: fontSize16,
            fontWeight: fontWeight400,
            padding: const EdgeInsets.only(
              bottom: float10,
            ),
          ),
          TextComponent(
            controller.myProfileData?.address ?? "Address not found",
            fontSize: fontSize16,
            fontWeight: fontWeight400,
            padding: const EdgeInsets.only(
              bottom: float10,
            ),
          ),
        ],
      );
    });
  }
}

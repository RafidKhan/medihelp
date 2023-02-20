import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/utils/styles.dart';

class AppbarWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onBackTap;
  final bool? hideBackButton;
  final Widget? prefixWidget;
  final bool? centerTitle;

  const AppbarWidget({
    Key? key,
    required this.title,
    this.hideBackButton = false,
    this.onBackTap,
    this.prefixWidget,
    this.centerTitle = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          backgroundColor: kPrimaryColor,
          scrolledUnderElevation: 0,
          centerTitle: centerTitle,
          leading: hideBackButton == true
              ? null
              : InkWell(
                  onTap: onBackTap ??
                      () {
                        Get.back();
                      },
                  child: const Icon(
                    Icons.arrow_back_outlined,
                    color: kWhiteColor,
                  ),
                ),
          title: TextComponent(
            title,
            padding: EdgeInsets.zero,
            fontSize: fontSize18,
            fontWeight: fontWeight700,
          ),
          actions: [
            prefixWidget ?? const SizedBox(),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          decoration: BoxDecoration(
            color: kFadedTextColor.withOpacity(0.07),
            boxShadow: const [
              defaultBoxShadow,
            ],
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/models/category_model.dart';
import 'package:medihelp/modules/dashboard/controller/dashboard_controller.dart';
import 'package:medihelp/utils/styles.dart';

class TabTitleWidget extends StatelessWidget {
  CategoryModel categoryModel;
  int index;

  TabTitleWidget({
    Key? key,
    required this.categoryModel,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: float10,
          vertical: float12,
        ),
        child: TextComponent(
          categoryModel.name ?? "",
          fontSize: fontSize14,
          fontWeight: index == controller.selectedDealTabIndex
              ? fontWeight600
              : fontWeight400,
          color: index == controller.selectedDealTabIndex
              ? kBlackColor
              : kFadedTextColor,
        ),
      );
    });
  }
}

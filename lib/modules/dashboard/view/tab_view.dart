import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/modules/dashboard/controller/dashboard_controller.dart';
import 'package:medihelp/modules/dashboard/view/tab_title_widget.dart';
import 'package:medihelp/utils/styles.dart';

class TabView extends StatelessWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float12,
        ),
        child: DefaultTabController(
          length: controller.listCategories.length,
          initialIndex: 0,
          child: TabBar(
            onTap: (index) {
              controller.selectDealTabIndex(index: index);
            },
            isScrollable: true,
            indicatorColor: kPrimaryColor,
            physics: const BouncingScrollPhysics(),
            tabs: [
              for (int index = 0;
                  index < controller.listCategories.length;
                  index++)
                TabTitleWidget(
                  categoryModel: controller.listCategories[index],
                  index: index,
                )
            ],
          ),
        ),
      );
    });
  }
}

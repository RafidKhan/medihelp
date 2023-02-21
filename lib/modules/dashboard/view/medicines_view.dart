import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/modules/dashboard/controller/dashboard_controller.dart';
import 'package:medihelp/modules/dashboard/view/medicine_tile.dart';
import 'package:medihelp/utils/styles.dart';

class MedicinesView extends StatelessWidget {
  const MedicinesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double itemHeight = 180;
    const double itemWidth = 156;
    return GetBuilder<DashboardController>(builder: (controller) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: horizontalMargin,
          vertical: float10,
        ),
        child: controller.loadingMedicines
            ? LoaderWidget()
            : controller.listMedicines.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.listMedicines.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: (itemWidth / itemHeight),
                            crossAxisCount: 2,
                            crossAxisSpacing: float10,
                            mainAxisSpacing: float12),
                    itemBuilder: (context, index) {
                      final medicineModel = controller.listMedicines[index];
                      return MedicineTile(
                        medicineModel: medicineModel,
                        height: itemHeight,
                        onTap: () {},
                        addToCart: () {
                          controller.addRemoveToCart(
                              isAdd: true, medicineModel: medicineModel);
                        },
                        removeFromCart: () {
                          controller.addRemoveToCart(
                              isAdd: false, medicineModel: medicineModel);
                        },
                      );
                    })
                : const TextComponent(
                    "No Medicine Found Under This Category",
                    fontSize: fontSize12,
                    fontWeight: fontWeight400,
                  ),
      );
    });
  }
}

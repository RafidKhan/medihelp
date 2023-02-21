import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/adatptive_button.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/components/app_bar_widget.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/modules/cart/view/cart_tile.dart';
import 'package:medihelp/modules/dashboard/controller/dashboard_controller.dart';
import 'package:medihelp/utils/styles.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return DefaultScaffold(
        appBar: AppbarWidget(
          title: "Cart",
          hideBackButton: true,
          prefixWidget: Container(
            margin: const EdgeInsets.only(
              right: horizontalMargin,
            ),
            child: Image.asset(
              Assets.icons.iconCart.path,
              height: 30,
              width: 30,
              color: kWhiteColor,
            ),
          ),
        ),
        body: ListView.builder(
          physics: bouncingPhysics,
          itemCount: controller.listMedicines.length,
          itemBuilder: (context, index) {
            final medicineModel = controller.listMedicines[index];
            final int cartAmount = medicineModel.cartAmount ?? 0;
            final bool isAddedToCart = medicineModel.isAddedToCart ?? false;
            if (isAddedToCart && cartAmount > 0) {
              return CartTile(
                medicineModel: medicineModel,
                removePermanent: () {
                  controller.permanentRemoveFromCart(
                      medicineModel: medicineModel);
                },
              );
            }
            return const SizedBox();
          },
        ),
        bottomNavigationBar: controller.calculateTotal() == 0
            ? null
            : Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: horizontalMargin, vertical: float12),
                width: MediaQuery.of(context).size.width,
                color: kSecondaryColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const TextComponent(
                          "Total: ",
                          fontSize: fontSize16,
                          fontWeight: fontWeight500,
                          textAlign: TextAlign.start,
                        ),
                        const Spacer(),
                        TextComponent(
                          "${controller.calculateTotal()}",
                          fontSize: fontSize16,
                          fontWeight: fontWeight500,
                          textAlign: TextAlign.start,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerRight,
                        child: AdaptiveButton(
                            btnText: "Confirm Order", onTap: () {})),
                  ],
                ),
              ),
      );
    });
  }
}

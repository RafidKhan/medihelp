import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/gen/assets.gen.dart';
import 'package:medihelp/models/medicine_model.dart';
import 'package:medihelp/modules/cart/controller/cart_controller.dart';
import 'package:medihelp/utils/styles.dart';

class MedicineTile extends StatelessWidget {
  MedicineModel medicineModel;
  VoidCallback onTap;
  VoidCallback addToCart;
  VoidCallback removeFromCart;
  double height;

  MedicineTile(
      {Key? key,
      required this.medicineModel,
      required this.onTap,
      required this.height,
      required this.addToCart,
      required this.removeFromCart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(
          bottom: float10,
        ),
        padding: const EdgeInsets.all(
          float10,
        ),
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(
              15,
            ),
            boxShadow: const [defaultBoxShadow]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: LoaderWidget(
                    size: 10,
                  ),
                ),
                errorWidget: (context, url, error) {
                  return Image.asset(
                    Assets.logo.appLogo.path,
                    height: height / 2,
                  );
                },
                imageUrl: medicineModel.image ?? "",
                height: height / 2,
                width: MediaQuery.of(context).size.width / 3,
                fit: BoxFit.fill,
              ),
            ),
            TextComponent(
              medicineModel.name ?? "",
              fontSize: fontSize14,
              fontWeight: fontWeight500,
              textAlign: TextAlign.start,
            ),
            TextComponent(
              "${(medicineModel.price ?? "")} BDT",
              fontSize: fontSize12,
              fontWeight: fontWeight400,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.only(
                top: float5,
              ),
            ),
            GetBuilder<CartController>(builder: (cartController) {
              return cartController.existsInCart(id: medicineModel.id ?? "") !=
                      null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: removeFromCart,
                          child: const Icon(
                            Icons.exposure_minus_1,
                            size: 15,
                          ),
                        ),
                        TextComponent(
                          "${cartController.existsInCart(id: medicineModel.id ?? "")!.quantity}",
                          fontSize: fontSize12,
                          fontWeight: fontWeight400,
                          textAlign: TextAlign.center,
                        ),
                        InkWell(
                          onTap: addToCart,
                          child: const Icon(
                            Icons.plus_one,
                            size: 15,
                          ),
                        ),
                      ],
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: TextComponent(
                        "add to cart",
                        fontSize: fontSize12,
                        fontWeight: fontWeight400,
                        textAlign: TextAlign.center,
                        padding: const EdgeInsets.only(
                          top: float5,
                        ),
                        onPressed: addToCart,
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}

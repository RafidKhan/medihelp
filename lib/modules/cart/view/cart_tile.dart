import 'package:flutter/material.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/models/medicine_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

class CartTile extends StatelessWidget {
  MedicineModel medicineModel;

  CartTile({
    Key? key,
    required this.medicineModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kCardColorLite,
      margin: const EdgeInsets.only(
        top: float10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: float10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowWidget(
            title: "Name",
            result: medicineModel.name ?? "",
          ),
          const SizedBox(
            height: 10,
          ),
          rowWidget(
            title: "Quantity",
            result: (medicineModel.cartAmount ?? 0).toString(),
          ),
          const SizedBox(
            height: 10,
          ),
          rowWidget(
            title: "Price",
            result:
                "${medicineModel.price}*${medicineModel.cartAmount} : ${multiplyStrings([
                  medicineModel.price.toString(),
                  medicineModel.cartAmount.toString(),
                ])}",
          ),
        ],
      ),
    );
  }

  Widget rowWidget({required String title, required String result}) {
    return Row(
      children: [
        TextComponent(
          "$title: ",
          fontSize: fontSize16,
          fontWeight: fontWeight500,
          textAlign: TextAlign.start,
        ),
        const Spacer(),
        TextComponent(
          result,
          fontSize: fontSize16,
          fontWeight: fontWeight500,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:medihelp/components/adatptive_button.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/models/cart_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/styles.dart';

class CartTile extends StatelessWidget {
  CartModel cartModel;
  VoidCallback removePermanent;

  CartTile({
    Key? key,
    required this.cartModel,
    required this.removePermanent,
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
            result: cartModel.name,
          ),
          const SizedBox(
            height: 10,
          ),
          rowWidget(
            title: "Quantity",
            result: "${cartModel.quantity}",
          ),
          const SizedBox(
            height: 10,
          ),
          rowWidget(
            title: "Price",
            result:
                "${cartModel.price}*${cartModel.quantity} : ${multiplyStrings([
                  cartModel.price.toString(),
                  cartModel.quantity.toString(),
                ])}",
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: AdaptiveButton(btnText: "Remove", onTap: removePermanent))
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

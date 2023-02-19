import 'package:flutter/material.dart';
import 'package:medihelp/components/loader_widget.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/utils/styles.dart';

class CommonButton extends StatelessWidget {
  final String btnText;
  final VoidCallback? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool? isLoading;
  final bool? isEnabled;
  final Color? buttonColor;
  final Color? textColor;
  final Color? borderColor;
  final bool? isTextTranslatable;

  CommonButton({
    Key? key,
    required this.btnText,
    this.onTap,
    this.margin,
    this.isLoading = false,
    this.isEnabled = true,
    this.buttonColor,
    this.textColor = kWhiteColor,
    this.borderColor,
    this.padding,
    this.isTextTranslatable = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading == true
        ? LoaderWidget()
        : InkWell(
            onTap: isEnabled == true ? onTap : null,
            child: Container(
              padding: padding ?? const EdgeInsets.symmetric(vertical: 15),
              margin: margin ?? EdgeInsets.zero,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: isEnabled == true
                    ? buttonColor ?? kPrimaryColor
                    : kDisabledButtonColor,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: borderColor ?? Colors.transparent),
              ),
              child: Center(
                child: TextComponent(
                  btnText,
                  padding: EdgeInsets.zero,
                  color: textColor,
                  fontSize: buttonFontSize,
                  fontWeight: buttonFontWeight,
                ),
              ),
            ),
          );
  }
}

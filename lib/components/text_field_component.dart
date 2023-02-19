import 'package:flutter/material.dart';
import 'package:medihelp/utils/styles.dart';

class TextFieldComponent extends StatefulWidget {
  final String hintText;
  final String? initialValue;
  final String? validatorText;
  final bool? isValidate;
  final EdgeInsets? margin;
  final Function(String? value)? onChanged;
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final bool? enabled;
  final bool? readOnly;
  final Widget? suffix;
  final int? maxLines;
  final int? maxLength;
  final VoidCallback? onTap;
  final Widget? suffixWidget;
  final Widget? prefixWidget;
  final TextInputType? keyboardType;

  TextFieldComponent({
    Key? key,
    required this.hintText,
    this.margin = EdgeInsets.zero,
    this.isValidate = true,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.suffix,
    this.validatorText,
    this.maxLines = 1,
    this.maxLength,
    this.onTap,
    this.suffixWidget,
    this.prefixWidget,
    this.validator,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<TextFieldComponent> createState() => _TextFieldComponentState();
}

class _TextFieldComponentState extends State<TextFieldComponent> {
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        margin: widget.margin,
        color: Colors.transparent,
        child: Form(
          key: formKey,
          child: TextFormField(
            initialValue: widget.initialValue,
            controller: widget.controller,
            enabled: widget.enabled ?? true,
            readOnly: widget.readOnly ?? false,
            maxLines: widget.maxLines ?? 1,
            maxLength: widget.maxLength,
            keyboardType: widget.keyboardType,
            style: textFieldStyle(),
            cursorColor: kBlackColor,
            decoration: InputDecoration(
              suffix: widget.suffixWidget,
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: float16, vertical: float16),
              hintText: widget.hintText,
              hintStyle: hintTextStyle(),
              fillColor: kWhiteColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: kTextFieldBorder,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: const BorderSide(
                  color: kTextFieldBorder,
                ),
              ),
              suffixIcon: widget.suffix,
              prefixIcon: widget.prefixWidget,
            ),
            onChanged: widget.onChanged != null
                ? (value) {
                    if (formKey.currentState != null &&
                        formKey.currentState!.validate()) {
                      widget.onChanged!(value);
                    } else {
                      widget.onChanged!(null);
                    }
                  }
                : null,
            validator: widget.isValidate == true
                ? widget.validator ??
                    (value) {
                      if (value.toString().trim().isEmpty) {
                        String text = "";
                        if (widget.validatorText == null) {
                          text = widget.hintText;
                        } else {
                          text = widget.validatorText!;
                        }
                        return "$text is required";
                      } else {
                        return null;
                      }
                    }
                : null,
          ),
        ),
      ),
    );
  }
}

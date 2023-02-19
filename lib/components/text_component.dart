import 'package:flutter/material.dart';
import 'package:medihelp/utils/styles.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextAlign textAlign;
  final EdgeInsets padding;
  final TextOverflow? textOverflow;
  final VoidCallback? onPressed;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? decorationColor;

  const TextComponent(
    this.text, {
    Key? key,
    this.onPressed,
    this.maxLines,
    this.textOverflow,
    this.textAlign = TextAlign.center,
    this.padding = EdgeInsets.zero,
    this.color,
    this.fontSize = fontSize12,
    this.fontWeight = fontWeight400,
    this.textDecoration = TextDecoration.none,
    this.decorationColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          decoration: textDecoration ?? TextDecoration.none,
          decorationColor: textDecoration == null
              ? Colors.transparent
              : decorationColor ?? Colors.transparent,
        ),
      ),
    );
  }
}

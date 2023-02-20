import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kPrimaryColor = Color(0xff5D737E);
const kSecondaryColor = Color(0xff64B6AC);
const kCardColor = Color(0xffC0FDFB);
const kCardColorLite = Color(0xffDAFFEF);
const kBackgroundColor = Color(0xffFCFFFD);
const kWhiteColor = Color(0xFFFFFFFF);
const kBlackColor = Color(0xFF000000);
const kDisabledButtonColor = Color(0x60000000);
const kFadedTextColor = Color(0xFF5D5F5E);
const kTextFieldBorder = Color(0xffDADADA);

const defaultPageTransition = Transition.fadeIn;

const double float5 = 5.0;
const double float10 = 10.0;
const double float12 = 12.0;
const double float16 = 16.0;
const double float20 = 20.0;
const double float24 = 24.0;
const double float36 = 36.0;
const double float40 = 40.0;
const double float50 = 50.0;
const double float60 = 60.0;

const double horizontalMargin = float24;
const double containerPadding = float16;
const double generalPadding = 10.0;

const double fontSize12 = 12.0;
const double fontSize14 = 14.0;
const double fontSize16 = 16.0;
const double fontSize18 = 18.0;
const double fontSize20 = 20.0;
const double fontSize22 = 22.0;
const double fontSize24 = 24.0;
const double fontSize32 = 32.0;
const double fontSize36 = 36.0;

const fontWeight400 = FontWeight.w400;
const fontWeight700 = FontWeight.w700;
const fontWeight600 = FontWeight.w600;
const fontWeight500 = FontWeight.w500;

const double buttonFontSize = fontSize14;
const FontWeight buttonFontWeight = fontWeight600;

const double appBarHeight = 60.0;

const ScrollPhysics bouncingPhysics = BouncingScrollPhysics();

TextStyle textFieldStyle() {
  return const TextStyle(
    color: kBlackColor,
    fontWeight: fontWeight400,
    fontSize: fontSize18,
  );
}

TextStyle hintTextStyle() {
  return const TextStyle(
    fontSize: fontSize16,
    fontWeight: fontWeight400,
    color: kFadedTextColor,
  );
}

const BoxShadow defaultBoxShadow = BoxShadow(
  color: Color(0x12838383),
  blurRadius: 12.0,
  spreadRadius: 0.0,
  offset: Offset(
    0.0,
    0.0,
  ),
);



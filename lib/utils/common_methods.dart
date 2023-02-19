import 'package:flutter/material.dart';

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

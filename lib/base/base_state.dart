import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/utils/styles.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  void resetGetXValues(List<Rxn<dynamic>?>? args) {
    if (args != null) {
      for (var arg in args) {
        arg?.value = null;
      }
    }
  }

  bool isBlank(List<dynamic>? args) {
    bool result = true;
    if (args != null) {
      for (int i = 0; i < args.length; i++) {
        if (args[i] == null) {
          result = true;
          break;
        } else if (args[i].toString().trim() == 'null') {
          result = true;
          break;
        } else if (args[i].toString().trim().isEmpty) {
          result = true;
          break;
        } else if (args[i].toString().trim().isNotEmpty) {
          result = false;
        }
      }
    }
    return result;
  }

  Widget noDataFoundWidget() {
    return const Center(
      child: TextComponent(
        "No data found",
        padding: EdgeInsets.zero,
        fontSize: fontSize16,
        fontWeight: fontWeight500,
      ),
    );
  }
}

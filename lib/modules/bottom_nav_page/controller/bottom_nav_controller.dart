import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medihelp/modules/dashboard/view/dashboard_view.dart';

class BottomNavController extends GetxController {
  int tabIndex = 0;
  final tabs = [
    const DashboardView(),
    const SizedBox(),
    const SizedBox(),
    const SizedBox(),
  ];
}

import 'package:get/get.dart';
import 'package:medihelp/modules/cart/view/cart_view.dart';
import 'package:medihelp/modules/dashboard/view/dashboard_view.dart';
import 'package:medihelp/modules/profile/view/profile_view.dart';
import 'package:medihelp/modules/search_medicine/view/search_medicine_view.dart';

class BottomNavController extends GetxController {
  int tabIndex = 0;
  final tabs = [
    const DashboardView(),
    const CartView(),
    const ProfileView(),
    const SearchMedicineView(),
  ];
}

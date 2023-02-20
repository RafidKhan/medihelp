import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/category_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/firebase_constants.dart';

class DashboardController extends GetxController {
  List<CategoryModel> listCategories = <CategoryModel>[];
  int selectedDealTabIndex = 0;

  Future<void> fetchCategories() async {
    listCategories = [];
    try {
      await FirebaseFirestore.instance
          .collection(TableCategory.collectionName)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          listCategories.add(CategoryModel(name: "All", id: ""));
        }
        for (int i = 0; i < value.docs.length; i++) {
          listCategories.add(CategoryModel.fromJson(value.docs[i].data()));
        }
      });
      fetchMedicines();
      update();
    } catch (e) {
      snackBarWidget(title: "Error Loading Categories", subTitle: "");
    }
  }

  Future<void> fetchMedicines() async {
    await FirebaseFirestore.instance
        .collection(TableMedicines.collectionName)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        print("HERE: ${jsonEncode(value.docs[i].data())}");
      }
    });
  }

  selectDealTabIndex({required int index}) {
    selectedDealTabIndex = index;
    update();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/search_medicine_model.dart';
import 'package:medihelp/modules/search_medicine/repository/search_medicine_repository.dart';

class SearchMedicineController extends GetxController {
  TextEditingController searchTextController = TextEditingController();

  SearchMedicineRepository searchMedicineRepository =
      SearchMedicineRepository();

  List<SearchMedicineModel>? searchResult = <SearchMedicineModel>[].obs;

  clearTextController() {
    searchTextController.clear();
    update();
  }

  Future searchMedicine() async {
    searchResult?.clear();
    update();
    try {
      if (searchTextController.text.isNotEmpty) {
        searchResult = await searchMedicineRepository.searchMedicine(
            medicineName: searchTextController.text.trim());
        clearTextController();
      }
    } catch (e) {
      throw e;
    }
  }
}

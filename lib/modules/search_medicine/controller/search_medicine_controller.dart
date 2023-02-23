import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:medihelp/api_client/api_client.dart';
import 'package:medihelp/models/search_medicine_model.dart';

class SearchMedicineController extends GetxController {
  TextEditingController searchTextController = TextEditingController();

  ApiClient apiClient = ApiClient();

  List<SearchMedicineModel> searchResult = <SearchMedicineModel>[].obs;

  clearTextController() {
    searchTextController.clear();
    update();
  }

  Future searchMedicine() async {
    searchResult.clear();
    update();
    try {
      if (searchTextController.text.isNotEmpty) {
        final String url =
            "https://drug-info-and-price-history.p.rapidapi.com/1/druginfo?drug=${searchTextController.text.trim()}";
        final Response? response = await apiClient.getRequest(url: url);
        if (response != null) {
          searchResult = searchMedicineModelFromJson(jsonEncode(response.data));
          clearTextController();
        }
      }
    } catch (e) {
      throw e;
    }
  }
}

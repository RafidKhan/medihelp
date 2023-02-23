import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:medihelp/api_client/api_client.dart';
import 'package:medihelp/models/search_medicine_model.dart';

class SearchMedicineRepository {
  ApiClient apiClient = ApiClient();

  Future<List<SearchMedicineModel>?> searchMedicine(
      {required String medicineName}) async {
    final String url =
        "https://drug-info-and-price-history.p.rapidapi.com/1/druginfo?drug=${medicineName.trim()}";
    final Response? response = await apiClient.getRequest(url: url);
    if (response != null) {
      final List<SearchMedicineModel>? searchMedicineModel =
          searchMedicineModelFromJson(jsonEncode(response.data));
      return searchMedicineModel;
    }
    return null;
  }
}

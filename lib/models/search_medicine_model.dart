// To parse this JSON data, do
//
//     final searchMedicineModel = searchMedicineModelFromJson(jsonString);

import 'dart:convert';

List<SearchMedicineModel> searchMedicineModelFromJson(String str) =>
    List<SearchMedicineModel>.from(
        json.decode(str).map((x) => SearchMedicineModel.fromJson(x)));

String searchMedicineModelToJson(List<SearchMedicineModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchMedicineModel {
  SearchMedicineModel({
    this.genericName,
    this.labelerName,
    this.brandName,
  });

  String? genericName;
  String? labelerName;
  String? brandName;

  factory SearchMedicineModel.fromJson(Map<String, dynamic> json) =>
      SearchMedicineModel(
        genericName: json["generic_name"] ?? "",
        labelerName: json["labeler_name"] ?? "",
        brandName: json["brand_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "generic_name": genericName,
        "labeler_name": labelerName,
        "brand_name": brandName,
      };
}

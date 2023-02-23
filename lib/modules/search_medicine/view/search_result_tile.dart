import 'package:flutter/material.dart';
import 'package:medihelp/components/text_component.dart';
import 'package:medihelp/models/search_medicine_model.dart';
import 'package:medihelp/utils/styles.dart';

class SearchResultTile extends StatelessWidget {
  SearchMedicineModel searchMedicineModel;

  SearchResultTile({
    Key? key,
    required this.searchMedicineModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: float20,
        vertical: float20,
      ),
      margin: const EdgeInsets.only(
        bottom: float10,
        left: horizontalMargin,
        right: horizontalMargin,
      ),
      decoration: BoxDecoration(
        color: kCardColorLite,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowItem(
            title: "Generic Name",
            content: searchMedicineModel.genericName ?? "",
          ),
          rowItem(
            title: "Brand Name",
            content: searchMedicineModel.brandName ?? "",
          ),
          rowItem(
            title: "Labeler Name",
            content: searchMedicineModel.labelerName ?? "",
          )
        ],
      ),
    );
  }

  Widget rowItem({required String title, required String content}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: float5),
      child: TextComponent(
        "$title: $content",
        fontSize: fontSize16,
        fontWeight: fontWeight400,
        textAlign: TextAlign.start,
        textOverflow: TextOverflow.ellipsis,
      ),
    );
  }
}

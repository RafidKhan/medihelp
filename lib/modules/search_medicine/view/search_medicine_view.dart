import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/app_bar_widget.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/search_medicine/controller/search_medicine_controller.dart';
import 'package:medihelp/utils/styles.dart';

class SearchMedicineView extends StatefulWidget {
  const SearchMedicineView({Key? key}) : super(key: key);

  @override
  State<SearchMedicineView> createState() => _SearchMedicineViewState();
}

class _SearchMedicineViewState extends State<SearchMedicineView> {
  final searchMedicineController = Get.put(SearchMedicineController());

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
        appBar: const AppbarWidget(
          title: "Search Medicine",
          hideBackButton: true,
        ),
        body: SingleChildScrollView(
          physics: bouncingPhysics,
          child: Column(
            children: [
              TextFieldComponent(
                controller: searchMedicineController.searchTextController,
                hintText: "Search Medicine",
                margin: const EdgeInsets.symmetric(
                  horizontal: horizontalMargin,
                  vertical: float20,
                ),
              ),
            ],
          ),
        ));
  }
}

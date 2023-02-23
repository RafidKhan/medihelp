import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medihelp/components/app_bar_widget.dart';
import 'package:medihelp/components/default_scaffold.dart';
import 'package:medihelp/components/text_field_component.dart';
import 'package:medihelp/modules/search_medicine/controller/search_medicine_controller.dart';
import 'package:medihelp/modules/search_medicine/view/search_result_tile.dart';
import 'package:medihelp/utils/common_methods.dart';
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
    return GetBuilder<SearchMedicineController>(builder: (controller) {
      return DefaultScaffold(
          appBar: const AppbarWidget(
            title: "Search Medicine",
            hideBackButton: true,
          ),
          body: SingleChildScrollView(
            physics: bouncingPhysics,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFieldComponent(
                        controller: controller.searchTextController,
                        hintText: "Search Medicine",
                        isValidate: false,
                        margin: const EdgeInsets.only(
                          left: horizontalMargin,
                          top: float20,
                          bottom: float20,
                          right: float5,
                        ),
                        suffix: controller.searchTextController.text.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  controller.clearTextController();
                                },
                                child: const Icon(
                                  Icons.clear,
                                  color: kFadedTextColor,
                                ),
                              )
                            : null,
                        onChanged: (value) {
                          controller.update();
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        closeSoftKeyBoard();
                        controller.searchMedicine();
                      },
                      icon: const Icon(Icons.search),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.searchResult.length,
                  itemBuilder: (context, index) {
                    final searchMedicineModel = controller.searchResult[index];
                    return SearchResultTile(
                      searchMedicineModel: searchMedicineModel,
                    );
                  },
                )
              ],
            ),
          ));
    });
  }
}

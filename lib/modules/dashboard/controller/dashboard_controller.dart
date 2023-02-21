import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/category_model.dart';
import 'package:medihelp/models/medicine_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/firebase_constants.dart';

class DashboardController extends GetxController {
  List<CategoryModel> listCategories = <CategoryModel>[];
  List<MedicineModel> listMedicines = <MedicineModel>[];
  int selectedDealTabIndex = 0;

  bool loadingMedicines = false;

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
      fetchAllMedicines();
      update();
    } catch (e) {
      snackBarWidget(title: "Error Loading Categories", subTitle: "");
    }
  }

  Future<void> fetchAllMedicines() async {
    loadingMedicines = true;
    listMedicines.clear();
    update();
    try {
      await FirebaseFirestore.instance
          .collection(TableMedicines.collectionName)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          listMedicines.add(MedicineModel.fromJson(value.docs[i].data()));
        }
        update();
      });
      loadingMedicines = false;
      update();
    } catch (e) {
      loadingMedicines = false;
      update();
      snackBarWidget(title: "Error Loading Medicines", subTitle: "");
    }
  }

  Future<void> fetchCategoryMedicines({required String categoryID}) async {
    loadingMedicines = true;
    listMedicines = [];
    update();
    try {
      await FirebaseFirestore.instance
          .collection(TableMedicines.collectionName)
          .where(TableMedicines.categoryId, isEqualTo: categoryID)
          .get()
          .then((value) {
        for (int i = 0; i < value.docs.length; i++) {
          listMedicines.add(MedicineModel.fromJson(value.docs[i].data()));
        }
        update();
      });
      loadingMedicines = false;
      update();
    } catch (e) {
      loadingMedicines = false;
      update();
      snackBarWidget(title: "Error Loading Medicines", subTitle: "");
    }
  }

  selectDealTabIndex({required int index}) {
    selectedDealTabIndex = index;
    update();
  }

  addRemoveToCart({required bool isAdd, required MedicineModel medicineModel}) {
    int cartAmount = medicineModel.cartAmount ?? 0;
    if (isAdd) {
      medicineModel.isAddedToCart = true;
      cartAmount = cartAmount + 1;
      medicineModel.cartAmount = cartAmount;
    } else {
      cartAmount = cartAmount - 1;
      medicineModel.cartAmount = cartAmount;
      if (cartAmount == 0) {
        medicineModel.isAddedToCart = false;
      }
    }

    update();
  }
}

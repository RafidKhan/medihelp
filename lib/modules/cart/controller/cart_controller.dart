import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:medihelp/models/cart_model.dart';
import 'package:medihelp/models/order_model.dart';
import 'package:medihelp/models/user_model.dart';
import 'package:medihelp/utils/common_methods.dart';
import 'package:medihelp/utils/firebase_constants.dart';

class CartController extends GetxController {
  List<CartModel> listCartMedicines = <CartModel>[];

  addToCart({required CartModel cartModel}) {
    CartModel? getCartItem = existsInCart(id: cartModel.id);
    if (getCartItem == null) {
      insertToCart(cartModel: cartModel);
    } else {
      updateCartData(cartModel: cartModel);
    }
  }

  updateCartData({required CartModel cartModel}) {
    for (int i = 0; i < listCartMedicines.length; i++) {
      final String id = listCartMedicines[i].id;
      if (id.trim() == cartModel.id.trim()) {
        listCartMedicines[i] = cartModel;
        break;
      }
    }

    update();
  }

  insertToCart({required CartModel cartModel}) {
    listCartMedicines.add(cartModel);
    update();
  }

  removeFromCart({required CartModel cartModel}) {
    if (cartModel.quantity == 0) {
      permanentRemoveFromCart(cartModel: cartModel);
    } else {
      updateCartData(cartModel: cartModel);
    }
  }

  permanentRemoveFromCart({required CartModel cartModel}) {
    CartModel? getCartItem = existsInCart(id: cartModel.id);
    if (getCartItem != null) {
      for (int i = 0; i < listCartMedicines.length; i++) {
        final String id = listCartMedicines[i].id;
        if (id.trim() == cartModel.id.trim()) {
          listCartMedicines.removeAt(i);
          break;
        }
      }
    }
    update();
  }

  CartModel? existsInCart({required String id}) {
    CartModel? cartModel;
    for (int i = 0; i < listCartMedicines.length; i++) {
      final CartModel element = listCartMedicines[i];
      final String medicineId = element.id;
      if (medicineId.trim() == id.trim()) {
        cartModel = element;
        break;
      }
    }
    return cartModel;
  }

  int calculateTotal() {
    int result = 0;
    listCartMedicines.forEach((element) {
      final int price = int.parse(element.price);
      final int quantity = element.quantity;
      final int itemTotalPrice = price * quantity;
      result = result + itemTotalPrice;
    });
    return result;
  }

  Future confirmOrder() async {
    final UserModel? userModel =
        await getUserData(FirebaseAuth.instance.currentUser?.uid ?? "");

    if (userModel != null) {
      if (userModel.address == null) {
        snackBarWidget(
            title: "Please update your address on profile", subTitle: "");
      } else {
        if (userModel.address!.trim().isEmpty) {
          snackBarWidget(
              title: "Please update your address on profile", subTitle: "");
        } else {
          try {
            showLoaderAlert();
            final List<dynamic> cartData = [];
            listCartMedicines.forEach((element) {
              cartData.add(element.toJson());
            });
            final String orderId = FirebaseFirestore.instance
                .collection(TableOrders.collectionName)
                .doc()
                .id;

            OrderModel orderModel = OrderModel(
              orderBy: userModel.userId ?? "",
              orderId: orderId,
              orderData: cartData,
              totalPrice: calculateTotal(),
              orderStatus: OrderStatus.status_pending
            );

            await FirebaseFirestore.instance
                .collection(TableOrders.collectionName)
                .doc(orderId)
                .set(orderModel.toJson());

            listCartMedicines.clear();
            Get.back();
            update();
            snackBarWidget(
                title: "Your order has been confirmed", subTitle: "");
          } catch (e) {
            Get.back();
            snackBarWidget(
                title: "Something went wrong",
                subTitle: "Failed to confirm order");
            throw e;
          }
        }
      }
    }
  }
}

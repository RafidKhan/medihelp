import 'package:get/get.dart';
import 'package:medihelp/models/cart_model.dart';

class CartController extends GetxController {
  List<CartModel> listCartMedicines = <CartModel>[];

  addToCart({required CartModel cartModel}) {
    CartModel? getCartItem = existsInCart(id: cartModel.id);
    if (getCartItem == null) {
      listCartMedicines.add(cartModel);
    } else {
      for (int i = 0; i < listCartMedicines.length; i++) {
        final String id = listCartMedicines[i].id;
        if (id.trim() == cartModel.id.trim()) {
          listCartMedicines[i] = cartModel;
          break;
        }
      }
    }
    update();
  }

  removeFromCart({required CartModel cartModel}) {
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
}

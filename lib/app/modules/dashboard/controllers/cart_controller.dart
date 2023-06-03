import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:in_food/app/Utils/snackbar_util.dart';
import 'package:in_food/app/routes/app_pages.dart';
import '../../../models/restaurant_model.dart';

class CartController extends GetxController {
  List<MenuItemModel> cartItems = [];
  User user = FirebaseAuth.instance.currentUser!;

  double get totalPayment => cartItems.fold(0, (sum, item) => sum + item.price);

  void decreaseQuantity(index) {
    cartItems.removeAt(index);
    update();
  }

  void increaseQuantity(MenuItemModel item) {
    cartItems.add(item);
    update();
  }

  placeOrder() async {
    if (cartItems.isNotEmpty) {
      Get.toNamed(Routes.PLACE_ORDER);
    } else {
      SnackbarUtils.showSnackbar(
        "Empty Cart",
        "Your cart is empty",
        SnackPosition.BOTTOM,
        const Duration(milliseconds: 1500),
      );
    }
  }

}

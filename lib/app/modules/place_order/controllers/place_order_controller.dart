import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:in_food/app/Utils/snackbar_util.dart';
import 'package:in_food/app/models/restaurant_model.dart';
import 'package:in_food/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:in_food/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:uuid/uuid.dart';

import '../../../models/order_model.dart';

class PlaceOrderController extends GetxController {
  List<MenuItemModel> items = Get.find<CartController>().cartItems;
  String selectedPaymentMethod = 'Choose Payment';
  List<String> paymentMethods = ['Choose Payment', 'Cash'];
  double amount = Get.find<CartController>().totalPayment;
  User? user = FirebaseAuth.instance.currentUser!;

  selectPayment(String paymentMethod) {
    selectedPaymentMethod = paymentMethod;
    update();
  }

  Future<void> placeOrder() async {
    if (Get.find<DashboardController>().userAddress.isNotEmpty) {
      if (selectedPaymentMethod != 'Choose Payment') {
        await placeOrderQuery(items, user!.uid);
        Get.back();
        Get.snackbar("Order Placed", "Your order has been placed successfully");
        items.clear();
        Get.find<CartController>().cartItems.clear();
        Get.find<CartController>().update();
        update();
      } else {
        SnackbarUtils.showSnackbar(
          "Payment Error",
          "Please choose your payment method",
          SnackPosition.BOTTOM,
          const Duration(milliseconds: 1500),
        );
      }
    } else {
      SnackbarUtils.showSnackbar(
        "Location Error",
        "Please choose your location",
        SnackPosition.BOTTOM,
        const Duration(milliseconds: 1500),
      );
    }
  }

  Future<void> placeOrderQuery(
      List<MenuItemModel> cartItems, String userId) async {
    // Create a Firestore instance
    print(user!.uid);
    print(userId);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    String orderId = Uuid().v4();
    DocumentReference orderRef = firestore.collection('orders').doc(orderId);
    String restaurantId = cartItems[0].restaurantId;
    // Convert the cart items to a List of Maps
    List<Map<String, dynamic>> itemDataList =
        cartItems.map((item) => item.toMap()).toList();

    OrderModel order = OrderModel(
      startTime: (DateTime.now().millisecondsSinceEpoch).toString(),
      userId: userId,
      restaurantId: restaurantId,
      items: itemDataList,
      status: 'new',
      eta: '',
      paymentMethod: selectedPaymentMethod,
      address: Get.find<DashboardController>().userAddress,
      orderId: orderId,
      reason: '',
      endTime: '',
      total: amount,
      lat: Get.find<DashboardController>().userLocation.latitude,
      lng: Get.find<DashboardController>().userLocation.longitude,
    );
    try {
      // Store the cart items in the order document
      await orderRef.set(order.toMap());
      // await orderRef.set({
      //   'restaurantId': restaurantId,
      //   'items': itemDataList,
      //   'status': '',
      //   'eta': '',
      //   'paymentMethod': ''
      // });
      print('Order placed successfully for restaurant $restaurantId!');
      // await FirebaseFirestore.instance
      //     .collection('users')
      //     .doc(userId)
      //     .collection('orders')
      //     .doc(restaurantId)
      //     .set({
      //   'restaurantId': restaurantId,
      //   'items': itemDataList,
      //   'status': '',
      //   'eta': '',
      //   'paymentMethod': ''
      // });
    } catch (error) {
      print('Failed to place order for restaurant $restaurantId: $error');
    }
  }
}

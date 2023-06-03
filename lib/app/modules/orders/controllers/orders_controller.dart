import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../models/order_model.dart';

class OrdersController extends GetxController {
  List<OrderModel> orders = [];
  User user = FirebaseAuth.instance.currentUser!;
  List<OrderModel> allOrders = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenOrders();
    listenAllOrders();
  }

  listenOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .where('status', whereIn: ['new', 'accepted', 'delivering'])
        .snapshots()
        .listen((event) {
          orders.clear();
          event.docs.forEach((element) {
            orders.add(OrderModel.fromMap(element.data()));
          });
          update();
        });
  }

  sortByStarttime() {
    allOrders.sort((b, a) => a.startTime.compareTo(b.startTime));
  }

  listenAllOrders() {
    FirebaseFirestore.instance
        .collection('orders')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .listen((event) {
      allOrders.clear();
      event.docs.forEach((element) {
        allOrders.add(OrderModel.fromMap(element.data()));
      });
      sortByStarttime();
      update();
    });
  }
}

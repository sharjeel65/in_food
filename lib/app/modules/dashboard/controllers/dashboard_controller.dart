import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:in_food/app/models/restaurant_model.dart';
import 'package:in_food/app/models/user_model.dart';
import 'package:in_food/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:in_food/app/modules/orders/controllers/orders_controller.dart';

class DashboardController extends GetxController {
  //TODO: Implement DashboardController
  User? user = FirebaseAuth.instance.currentUser;
  UserModel userModel = UserModel();
  List<RestaurantModel> restaurantModels = <RestaurantModel>[];
  bool amountApplied = false;
  TextEditingController amountController = TextEditingController();
  FocusNode amountFocusNode = FocusNode();
  int? amount;
  CartController cartController = Get.put(CartController());
  OrdersController ordersController = Get.put(OrdersController());
  LatLng userLocation = LatLng(0, 0);
  String userAddress = "";

  Marker marker = Marker(
    markerId: MarkerId("userLocation"),
    position: LatLng(0, 0),
  );

  listenUserData() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots()
        .listen((event) {
      userModel = UserModel.fromDocumentSnapshot(event);
      update();
    });
  }

  longPress(LatLng latLng) async {
    marker = Marker(
      markerId: const MarkerId("user"),
      position: latLng,
      infoWindow: InfoWindow(title: "Your Location"),
    );
    userLocation = latLng;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude, latLng.longitude,
        localeIdentifier: 'en');
    userAddress = "${placemarks[0].street}, ${placemarks[0].subLocality}";
    update();
  }

  checkLocationPermission() async {
    final value = await Geolocator.checkPermission();
    if (value == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (value == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied",
          "Please allow location permission from settings");
    }
  }

  getUserLocation() async {
    checkLocationPermission();
    try {
      var currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 3),
      );
      userLocation =
          LatLng(currentLocation.latitude, currentLocation.longitude);
    } on TimeoutException catch (e) {
      print("lastlocation");
      Position? pos = await Geolocator.getLastKnownPosition();
      print("returning last pos");
      return LatLng(pos!.latitude, pos.longitude);
    }
    List<Placemark> placemarks = await placemarkFromCoordinates(
        userLocation.latitude, userLocation.longitude,
        localeIdentifier: 'en');
    userAddress = "${placemarks[0].street}, ${placemarks[0].subLocality}";
    marker = Marker(
      markerId: const MarkerId("user"),
      position: userLocation,
      infoWindow: InfoWindow(title: "Your Location"),
    );
    update();
  }

  // locationPicker(){
  //   Get.dialog(
  //     GoogleMap(initialCameraPosition: ,)
  //   );
  // }
  applyAmount() {
    if (amountController.text.isNotEmpty) {
      amountApplied = true;
      amount = int.parse(amountController.text);
      update();
    }
  }

  clearFilter() {
    amountApplied = false;
    amountController.clear();
    amountFocusNode.unfocus();
    update();
  }

  void listenToCollection() {
    FirebaseFirestore.instance
        .collection('restaurants')
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      restaurantModels.clear(); // Clear the existing list before updating
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        var restaurantModel = RestaurantModel.fromSnapshot(documentSnapshot);
        restaurantModels.add(restaurantModel);
      });
      update();
    });
  }

  amountToggle() {
    amountApplied = !amountApplied;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    listenUserData();
    listenToCollection();
    getUserLocation();
  }

  unFocus() {
    amountFocusNode.unfocus();
    update();
  }

  void addToCart(MenuItemModel item) {
    if (Get.find<CartController>().cartItems.isNotEmpty) {
      if (Get.find<CartController>().cartItems[0].restaurantId ==
          item.restaurantId) {
        Get.find<CartController>().cartItems.add(item);
        Get.find<CartController>().update();
      } else {
        Get.snackbar(
          "Cart Error",
          "You can only order from one restaurant in a single order",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(milliseconds: 1500),
        );
      }
    } else {
      Get.find<CartController>().cartItems.add(item);
      Get.find<CartController>().update();
    }
    update();
  }
}

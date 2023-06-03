import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  checkLocationPermission() async {
    final value = await Geolocator.checkPermission();
    if (value == LocationPermission.denied) {
      await Geolocator.requestPermission();
    } else if (value == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied",
          "Please allow location permission from settings");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLocationPermission();
  }
}

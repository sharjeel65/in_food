import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:in_food/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:lottie/lottie.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        centerTitle: true,
      ),
      body: GetBuilder<OrdersController>(
        builder: (controller) {
          if (controller.allOrders.isNotEmpty) {
            return ListView.builder(
              itemCount: controller.allOrders.length,
              itemBuilder: (context, index) {
                final restaurant = Get.find<DashboardController>()
                    .restaurantModels
                    .firstWhere((element) =>
                        element.id == controller.allOrders[index].restaurantId);
                final status = controller.allOrders[index].status;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              status == 'delivered'
                                  ? _calculateTimeTook(
                                      controller.allOrders[index].startTime,
                                      controller.allOrders[index].endTime)
                                  : _calculateTimeRemaining(
                                      controller.allOrders[index].eta),
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 8,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        leading: status == 'rejected'
                            ? Icon(
                                Icons.error,
                                color: Colors.red,
                                size: 70.sp,
                              )
                            : status == 'new'
                                ? Lottie.asset('assets/lottie/waiting.json')
                                : status == 'delivering'
                                    ? Lottie.asset(
                                        'assets/lottie/delivery.json')
                                    : status == 'delivered'
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Colors.green,
                                            size: 50.sp,
                                          )
                                        : Lottie.asset(
                                            'assets/lottie/cooking.json'),
                        title: Row(
                          children: [
                            Text(
                              'Restaurant: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              '${restaurant.name}',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Status: ',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.allOrders[index].status,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '${controller.allOrders[index].total}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text(
                'No orders yet',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            );
          }
        },
      ),
    );
  }

  String _calculateTimeRemaining(String eta) {
    if (eta == '0' || eta == 'null' || eta == '') {
      return '';
    }
    print(eta);
    DateTime futureTime = DateTime.fromMillisecondsSinceEpoch(int.parse(eta));
    Duration remainingDuration = futureTime.difference(DateTime.now());
    int hours = remainingDuration.inHours;
    int minutes = remainingDuration.inMinutes.remainder(60);
    int seconds = remainingDuration.inSeconds.remainder(60);

    String timeRemaining = '';

    if (hours > 0) {
      timeRemaining += '$hours h ';
    }
    if (minutes > 0) {
      timeRemaining += '$minutes min ';
    }
    if (seconds < 0) {
      return '1 min';
    }
    timeRemaining += '$seconds sec';

    return timeRemaining;
  }

  String _calculateTimeTook(String startTime, String endTime) {
    DateTime start = DateTime.fromMillisecondsSinceEpoch(int.parse(startTime));
    DateTime end = DateTime.fromMillisecondsSinceEpoch(int.parse(endTime));
    Duration difference = end.difference(start);
    return '${difference.inMinutes} min ${difference.inSeconds.remainder(60)} sec';
  }
}

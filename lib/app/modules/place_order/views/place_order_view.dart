import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_food/app/models/restaurant_model.dart';
import 'package:in_food/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:in_food/app/routes/app_pages.dart';
import '../controllers/place_order_controller.dart';

class PlaceOrderView extends GetView<PlaceOrderController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Place Order'),
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                MenuItemModel item = controller.items[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.imageUrl),
                    ),
                    title: Text(item.name),
                    trailing: Text('Rs. ${item.price.toStringAsFixed(2)}'),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total Amount: Rs. ${controller.amount}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                GetBuilder<PlaceOrderController>(builder: (controller) {
                  return DropdownButton<String>(
                    value: controller.selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      controller.selectPayment(newValue!);
                    },
                    items:
                        controller.paymentMethods.map<DropdownMenuItem<String>>(
                      (String paymentMethod) {
                        return DropdownMenuItem<String>(
                          value: paymentMethod,
                          child: Text(paymentMethod),
                        );
                      },
                    ).toList(),
                  );
                }),
                SizedBox(height: 16),
                GetBuilder<DashboardController>(builder: (controller) {
                  return InkWell(
                    onTap: (){
                      Get.toNamed(Routes.LOCATION);
                    },
                    child: Row(
                      children: [
                        Text(
                          controller.userAddress,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                  );
                }),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.placeOrder();
                  },
                  child: Text('Place Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

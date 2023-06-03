import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<CartController>(builder: (controller) {
              if (controller.cartItems.isNotEmpty) {
                return ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartItems[index];
                    return Card(
                      child: ListTile(
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        leading: Image.network(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.name),
                        subtitle: Text(item.description),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      controller.decreaseQuantity(index),
                                  child: Icon(Icons.remove),
                                ),
                                SizedBox(width: 8),
                                // Text(item.quantity.toString()),
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () =>
                                      controller.increaseQuantity(item),
                                  child: Icon(Icons.add),
                                ),
                              ],
                            ),
                            Text("Rs.${item.price}"),
                          ],
                        ),
                        onTap: () {
                          // Navigate to item details screen
                          // Get.toNamed(
                          //   '/itemDetails',
                          //   arguments: {'item': item},
                          // );
                        },
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('Cart is empty'),
                );
              }
            }),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Payment:',
                  style: TextStyle(fontSize: 16),
                ),
                GetBuilder<CartController>(builder: (context) {
                  return Text(
                    'Rs.${controller.totalPayment}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  );
                }),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              controller.placeOrder();
            },
            child: Text('Place Order'),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

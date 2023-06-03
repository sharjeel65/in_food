import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_food/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:in_food/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:in_food/app/modules/restaurant/controllers/restaurant_controller.dart';
import 'package:in_food/app/routes/app_pages.dart';

class RestaurantView extends GetView<RestaurantController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant View'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.restaurantModel!.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.restaurantModel!.tagline,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Image.network(
                    controller.restaurantModel!.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Address:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.restaurantModel!.address),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.restaurantModel!.description),
                  SizedBox(height: 16),
                  Text(
                    'Phone:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.restaurantModel!.phone),
                  SizedBox(height: 16),
                  Text(
                    'Email:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.restaurantModel!.email),
                  SizedBox(height: 16),
                  Text(
                    'Website:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(controller.restaurantModel!.website),
                  SizedBox(height: 16),
                  Text(
                    'Menus:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.restaurantModel!.menus.length,
                    itemBuilder: (context, index) {
                      final menu = controller.restaurantModel!.menus[index];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(menu.description),
                          SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: menu.items.length,
                            itemBuilder: (context, index) {
                              final item = menu.items[index];
                              return Card(
                                child: ListTile(
                                  leading: Image.network(
                                    item.imageUrl,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(item.name),
                                  subtitle: Text(item.description),
                                  trailing: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Get.find<DashboardController>()
                                              .addToCart(item);
                                        },
                                        child:
                                            Icon(Icons.add_shopping_cart_sharp),
                                      ),
                                      Text("Rs.${item.price}"),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 60),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          GetBuilder<CartController>(builder: (controller) {
            return Positioned(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.95,
                height: 70,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Spacer(),
                    Text(
                      'Rs.${controller.totalPayment}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.CART);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                          Text(
                            '(${controller.cartItems.length})',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed(Routes.CART);
                      },
                      child: Text('Place Order'),
                    ),
                    Spacer(),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

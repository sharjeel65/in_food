import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_food/app/Services/validator.dart';
import 'package:in_food/app/models/restaurant_model.dart';
import 'package:in_food/app/modules/dashboard/controllers/cart_controller.dart';
import 'package:in_food/app/modules/orders/controllers/orders_controller.dart';
import 'package:in_food/app/routes/app_pages.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomAppBar(context),
      appBar: _appbar(context),
      body: GetBuilder<DashboardController>(builder: (controller) {
        return Container(
          color: Theme.of(context).colorScheme.surface,
          child: Column(
            children: [
              !controller.amountApplied
                  ? Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 0.h,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                    GetBuilder<DashboardController>(
                                        builder: (controller) {
                                      if (controller.restaurantModels.isEmpty) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        RestaurantModel restaurant =
                                            controller.restaurantModels[0];
                                        return ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Get.toNamed(
                                                    Routes.RESTAURANT,
                                                    arguments: restaurant,
                                                  );
                                                },
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      restaurant.imageUrl,
                                                      fit: BoxFit.fitWidth,
                                                      height: 200.h,
                                                      width: double.infinity,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            restaurant.name,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Text(
                                                            restaurant.tagline,
                                                          ),
                                                          Text(
                                                            restaurant.email,
                                                          ),
                                                          const Row(
                                                            children: [
                                                              Text(
                                                                'Rating: ',
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Icon(Icons
                                                                  .star_outlined),
                                                              Icon(Icons
                                                                  .star_outlined),
                                                              Icon(Icons
                                                                  .star_outlined),
                                                              Icon(Icons
                                                                  .star_outlined),
                                                              Icon(Icons
                                                                  .star_half_outlined),
                                                              Spacer(),
                                                              Text(
                                                                '45 minutes',
                                                              ),
                                                              Icon(Icons
                                                                  .home_outlined),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      }
                                    }),
                                  ],
                                ),
                              ),
                            ),
                            // Card(
                            //   child: Container(
                            //     margin: EdgeInsets.symmetric(
                            //         horizontal: 10, vertical: 0),
                            //     child: Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         const SizedBox(height: 10),
                            //         Text(
                            //           'Popular Cuisines',
                            //           style: TextStyle(
                            //             fontSize: 18,
                            //             fontWeight: FontWeight.bold,
                            //           ),
                            //         ),
                            //         const SizedBox(height: 10),
                            //         Row(
                            //           children: [
                            //             Column(
                            //               children: [
                            //                 Image.network(
                            //                   "https://www.acupofkarachi.com/wp-content/uploads/2019/10/tandoor1.jpg",
                            //                   fit: BoxFit.fitWidth,
                            //                   height: 200.h,
                            //                 ),
                            //                 Padding(
                            //                   padding: EdgeInsets.all(8.0),
                            //                   child: Text(
                            //                     'Cuisine Name',
                            //                     style: TextStyle(
                            //                       fontWeight: FontWeight.bold,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ],
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Popular Restaurants',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'View All',
                                      style: TextStyle(
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.restaurantModels.length,
                                //popularRestaurants.length,
                                itemBuilder: (context, index) {
                                  final restaurant =
                                      controller.restaurantModels[index];
                                  return InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        Routes.RESTAURANT,
                                        arguments: restaurant,
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.network(
                                                restaurant.imageUrl,
                                                width: 160.w,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            restaurant.name,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            restaurant.tagline,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //       horizontal: 16, vertical: 12),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         'Trending Deals',
                            //         style: TextStyle(
                            //           fontSize: 18,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //       TextButton(
                            //         onPressed: () {},
                            //         child: Text(
                            //           'View All',
                            //           style: TextStyle(
                            //             color: Colors.orange,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   height: 200,
                            //   child: ListView.builder(
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: 5, //trendingDeals.length,
                            //     itemBuilder: (context, index) {
                            //       // final deal = trendingDeals[index];
                            //       return Padding(
                            //         padding: const EdgeInsets.all(8.0),
                            //         child: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             Expanded(
                            //               child: ClipRRect(
                            //                 borderRadius:
                            //                     BorderRadius.circular(8),
                            //                 child: Image.network(
                            //                   "https://www.brandsynario.com/wp-content/uploads/Deals01.jpg",
                            //                   width: 240,
                            //                   fit: BoxFit.cover,
                            //                 ),
                            //               ),
                            //             ),
                            //             SizedBox(height: 8),
                            //             const Text(
                            //               "deal.title",
                            //               style: TextStyle(
                            //                 fontSize: 16,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //             SizedBox(height: 4),
                            //             Text(
                            //               "deal.description",
                            //               style: TextStyle(
                            //                 fontSize: 12,
                            //                 color: Colors.grey[600],
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  : _amountApplied(context),
            ],
          ),
        );
      }),
    );
  }

  Widget _amountApplied(context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            controller.unFocus();
          },
          child: Container(
            color: Colors.transparent,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('restaurants')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Column(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: snapshot.data!.docs
                                  .map((DocumentSnapshot document) {
                                Map<String, dynamic> data =
                                    document.data()! as Map<String, dynamic>;
                                List menuItems = data['menus'];
                                return Card(
                                  color: Theme.of(context)
                                      .colorScheme.secondaryVariant,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    margin: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                data['name'],
                                                style: TextStyle(
                                                  fontSize: 22,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {
                                                Get.toNamed(Routes.RESTAURANT,
                                                    arguments: RestaurantModel
                                                        .fromSnapshot(
                                                            document));
                                              },
                                              icon: Icon(Icons.arrow_forward),
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                            )
                                          ],
                                        ),
                                        ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: menuItems.length,
                                            itemBuilder: (context, index) {
                                              List<MenuItemModel> items =
                                                  menuItems[index]['items']
                                                      .map<MenuItemModel>(
                                                          (item) =>
                                                              MenuItemModel
                                                                  .fromMap(
                                                                      item))
                                                      .toList();
                                              return ListView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: items.length,
                                                  shrinkWrap: true,
                                                  itemBuilder:
                                                      (context, index) {
                                                    if (controller.amount! >=
                                                        items[index].price) {
                                                      return Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                          vertical: 2.h,
                                                        ),
                                                        child: Card(
                                                          color:
                                                              Theme.of(context)
                                                                  .colorScheme
                                                                  .onPrimary,
                                                          child: ListTile(
                                                            visualDensity:
                                                                VisualDensity
                                                                    .adaptivePlatformDensity,
                                                            leading:
                                                                Image.network(
                                                              items[index]
                                                                  .imageUrl,
                                                              width: 50.w,
                                                              height: 50.h,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            title: Text(
                                                                items[index]
                                                                    .name),
                                                            subtitle: Text(items[
                                                                    index]
                                                                .description),
                                                            trailing: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              children: [
                                                                InkWell(
                                                                  onTap: () {
                                                                    controller
                                                                        .addToCart(
                                                                            items[index]);
                                                                  },
                                                                  child: Icon(Icons
                                                                      .add_shopping_cart_sharp),
                                                                ),
                                                                Text(
                                                                    "Rs.${items[index].price}"),
                                                              ],
                                                            ),
                                                            onTap: () {
                                                              // Get.toNamed(
                                                              //     '/itemDetails',
                                                              //     arguments: {
                                                              //       'item': items[
                                                              //           index]
                                                              //     });
                                                            },
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  });
                                            }),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  AppBar _appbar(context) {
    return AppBar(
      toolbarHeight: 100.h, // Adjust the height as needed
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      flexibleSpace: Column(
        children: [
          SizedBox(height: 30.h),
          Center(
            child: Text(
              'InFood',
              style: GoogleFonts.sacramento(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          GetBuilder<DashboardController>(builder: (controller) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.amountController,
                      // Replace with your controller
                      keyboardType: TextInputType.number,
                      focusNode: controller.amountFocusNode,
                      // Replace with your focus node
                      validator: (value) => Validator.validateAmount(value!),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      decoration: InputDecoration(
                        constraints: BoxConstraints(
                          maxHeight: 40,
                        ),
                        hintText: 'Enter Amount',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context)
                              .colorScheme
                              .onPrimary
                              .withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      controller.applyAmount(); // Replace with your function
                      controller.unFocus(); // Replace with your function
                    },
                    icon: Icon(
                      Icons.search,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    onPressed: () {
                      controller.clearFilter(); // Replace with your function
                    },
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  BottomAppBar _bottomAppBar(context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Get.toNamed(Routes.PROFILE);
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(controller.user?.photoURL ?? 'https://st3.depositphotos.com/6672868/13701/v/450/depositphotos_137014128-stock-illustration-user-profile-icon.jpg',
                  ),
                ),
              ),
            ),
          ),
          GetBuilder<DashboardController>(builder: (controller) {
            return Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOCATION);
                  },
                  child: Text(
                    controller.userLocation.latitude == 0 &&
                            controller.userLocation.longitude == 0
                        ? 'Choose Location'
                        : controller.userAddress,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Icon(Icons.arrow_drop_down_outlined)
              ],
            );
          }),
          Spacer(),
          GetBuilder<OrdersController>(builder: (controller) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.ORDERS);
              },
              child: Badge(
                label: Text(
                  '${controller.orders.length}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.delivery_dining,
                  size: 35.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }),
          SizedBox(width: 10),
          GetBuilder<CartController>(builder: (controller) {
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.CART);
              },
              child: Badge(
                label: Text(
                  '${controller.cartItems.length}',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  size: 35.sp,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

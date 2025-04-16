import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';
import 'package:scrap_it/screens/seller/viewShopOrders/controllers/view_shop_orders_controller.dart';
import 'package:scrap_it/screens/seller/viewShopOrders/views/components/order_tile.dart';

class ViewAllOrdersScreen extends StatelessWidget {
  const ViewAllOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetX<ViewShopOrdersController>(
              init: ViewShopOrdersController(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TopHeaderWithBackButton(title: 'My Orders'),
                    SizedBox(
                      height: 20.0,
                    ),
                    controller.isLoading.value
                        ? CircularProgressIndicator(
                            color: kPrimaryColor,
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: controller.userOrders.length,
                              itemBuilder: (context, index) {
                                log(controller.userOrders[index].items
                                    .toString());
                                return OrderTile(
                                  userOrder: controller.userOrders[index],
                                );
                              },
                            ),
                          ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

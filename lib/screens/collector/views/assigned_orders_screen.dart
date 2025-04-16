import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/controllers/assigned_orders_controller.dart';
import 'package:scrap_it/screens/collector/views/components/assigned_order_tile.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';

class AssignedOrdersScreen extends StatelessWidget {
  const AssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetX<AssignedOrdersController>(
            init: AssignedOrdersController(),
            builder: (controller) {
              return Column(
                children: [
                  TopHeaderWithBackButton(title: 'Assigned Orders'),
                  const SizedBox(height: 20),
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
                      : controller.assignedOrders.isEmpty
                      ? Center(child: Text('No assigned orders', style: kSubtitleStyle))
                      : Expanded(
                    child: ListView.builder(
                      itemCount: controller.assignedOrders.length,
                      itemBuilder: (context, index) {
                        return AssignedOrderTile(order: controller.assignedOrders[index]);
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
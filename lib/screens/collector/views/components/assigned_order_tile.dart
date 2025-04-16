import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/models/assigned_order_model.dart';
import 'package:scrap_it/screens/collector/views/order_detail_screen.dart';

class AssignedOrderTile extends StatelessWidget {
  final AssignedOrderModel order;

  const AssignedOrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () => Get.to(() => OrderDetailScreen(order: order)),
        title: Text('Order ID: ${order.id}', style: kTitle3Style),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${order.deliveryAddress}', style: kSubtitle2Style),
            Text('Date: ${order.timestamp.toDate().toString().substring(0, 10)}', style: kSubtitle2Style),
            Text('Status: ${order.status}', style: kSubtitle2Style),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
      ),
    );
  }
}
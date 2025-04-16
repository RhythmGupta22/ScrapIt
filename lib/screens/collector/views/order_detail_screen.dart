import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/controllers/assigned_orders_controller.dart';
import 'package:scrap_it/screens/collector/models/assigned_order_model.dart';
import 'package:scrap_it/screens/collector/views/track_order_screen.dart';
import 'package:scrap_it/screens/seller/shop/data/order_satuses.dart';
import 'package:scrap_it/sharedWidgets/status_updater.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';

class OrderDetailScreen extends StatelessWidget {
  final AssignedOrderModel order;

  const OrderDetailScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssignedOrdersController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeaderWithBackButton(title: 'Order Details'),
              const SizedBox(height: 20),
              Text('Order ID: ${order.id}', style: kTitle3Style),
              Text('Delivery Address: ${order.deliveryAddress}', style: kSubtitleStyle),
              Text('Date: ${order.timestamp.toDate().toString().substring(0, 10)}', style: kSubtitleStyle),
              Text('Payment Option: ${order.paymentOption}', style: kSubtitleStyle),
              Text('Contact: ${order.contactName} (${order.contactNumber})', style: kSubtitleStyle),
              const SizedBox(height: 10),
              Text('Items:', style: kTitle3Style),
              Expanded(
                child: ListView.builder(
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return ListTile(
                      leading: Image.network(item.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                      title: Text(item.name, style: kSubtitleStyle),
                      subtitle: Text('Qty: ${item.quantity} | Price: Rs ${item.price}', style: kSubtitle2Style),
                    );
                  },
                ),
              ),
              Text('Status:', style: kTitle3Style),
              StatusUpdater(
                currentStatus: order.status,
                statuses: orderStatuses,
                onStatusChanged: (newStatus) => controller.updateOrderStatus(order.id, newStatus),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.to(() => TrackOrderScreen(order: order)),
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white),
                child: const Text('Track Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/models/assigned_order_model.dart';
import 'package:scrap_it/screens/seller/shop/data/order_satuses.dart';

class TrackOrderScreen extends StatelessWidget {
  final AssignedOrderModel order;

  const TrackOrderScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(19.0750, 72.9988), // Placeholder, replace with order location
                    zoom: 11.4746,
                  ),
                  markers: {
                    const Marker(
                      markerId: MarkerId('Delivery Location'),
                      position: LatLng(19.0750, 72.9988),
                      infoWindow: InfoWindow(title: 'Delivery Location'),
                    ),
                  },
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(UIcons.regularRounded.angle_small_left, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Order ID:', style: kTitle2LessEmphasis),
                      Text(order.id, style: kTitle2Style.copyWith(color: kPrimaryColor)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StepProgressIndicator(
                    totalSteps: 4,
                    currentStep: int.parse(order.status) + 1,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    size: 125,
                    selectedColor: kPrimaryColor,
                    unselectedColor: Colors.black12,
                    customStep: (index, color, _) => color == kPrimaryColor
                        ? Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: color,
                          child: Icon(UIcons.boldRounded.check, size: 15, color: Colors.white),
                        ),
                        Text(orderStatuses[index], style: kSubtitle3Style, textAlign: TextAlign.center),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: color,
                          child: Icon(UIcons.boldRounded.cross, size: 15, color: Colors.black),
                        ),
                        Text(orderStatuses[index], style: kSubtitle3Style, textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  const Spacer(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundColor: kPrimaryColor,
                      child: Icon(UIcons.boldRounded.user, color: Colors.white, size: 20),
                    ),
                    title: Text('User Contact', style: kTitle3Style),
                    subtitle: Text('${order.contactName}\n${order.contactNumber}', style: kSubtitleStyle),
                    trailing: CircleAvatar(
                      radius: 25,
                      backgroundColor: kPrimaryColor,
                      child: Icon(UIcons.regularRounded.phone_call, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
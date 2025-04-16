import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/controllers/assigned_pickups_controller.dart';
import 'package:scrap_it/screens/collector/models/assigned_pickup_model.dart';
import 'package:scrap_it/screens/collector/views/track_pickup_screen.dart';
import 'package:scrap_it/screens/seller/trashPickup/data/pickup_statuses.dart';
import 'package:scrap_it/sharedWidgets/status_updater.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';

class PickupDetailScreen extends StatelessWidget {
  final AssignedPickupModel pickup;

  const PickupDetailScreen({super.key, required this.pickup});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AssignedPickupsController>();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopHeaderWithBackButton(title: 'Pickup Details'),
              const SizedBox(height: 20),
              Text('Pickup ID: ${pickup.id}', style: kTitle3Style),
              Text('Address: ${pickup.pickUpAddress}', style: kSubtitleStyle),
              Text('Date: ${pickup.selectedDate.toDate().toString().substring(0, 10)}', style: kSubtitleStyle),
              Text('Time Slot: ${pickup.selectedTimeSlotString}', style: kSubtitleStyle),
              Text('Waste Types: ${pickup.selectedWasteTypes.join(", ")}', style: kSubtitleStyle),
              Text('Instructions: ${pickup.instructions}', style: kSubtitleStyle),
              Text('Contact: ${pickup.contactName} (${pickup.contactNumber})', style: kSubtitleStyle),
              const SizedBox(height: 20),
              Text('Status:', style: kTitle3Style),
              StatusUpdater(
                currentStatus: pickup.status,
                statuses: pickupStatuses,
                onStatusChanged: (newStatus) => controller.updatePickupStatus(pickup.id, newStatus),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () => Get.to(() => TrackPickupScreen(pickup: pickup)),
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor, foregroundColor: Colors.white),
                child: const Text('Track Pickup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
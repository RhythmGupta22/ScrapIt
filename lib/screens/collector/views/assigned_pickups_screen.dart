import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/controllers/assigned_pickups_controller.dart';
import 'package:scrap_it/screens/collector/views/components/assigned_pickup_tile.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';

class AssignedPickupsScreen extends StatelessWidget {
  const AssignedPickupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetX<AssignedPickupsController>(
            init: AssignedPickupsController(),
            builder: (controller) {
              return Column(
                children: [
                  TopHeaderWithBackButton(title: 'Assigned Pickups'),
                  const SizedBox(height: 20),
                  controller.isLoading.value
                      ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
                      : controller.assignedPickups.isEmpty
                      ? Center(child: Text('No assigned pickups', style: kSubtitleStyle))
                      : Expanded(
                    child: ListView.builder(
                      itemCount: controller.assignedPickups.length,
                      itemBuilder: (context, index) {
                        return AssignedPickupTile(pickup: controller.assignedPickups[index]);
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
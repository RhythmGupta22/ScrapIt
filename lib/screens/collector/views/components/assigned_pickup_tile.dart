import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/models/assigned_pickup_model.dart';
import 'package:scrap_it/screens/collector/views/pickup_detail_screen.dart';

class AssignedPickupTile extends StatelessWidget {
  final AssignedPickupModel pickup;

  const AssignedPickupTile({super.key, required this.pickup});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () => Get.to(() => PickupDetailScreen(pickup: pickup)),
        title: Text('Pickup ID: ${pickup.id}', style: kTitle3Style),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: ${pickup.pickUpAddress}', style: kSubtitle2Style),
            Text('Date: ${pickup.selectedDate.toDate().toString().substring(0, 10)}', style: kSubtitle2Style),
            Text('Status: ${pickup.status}', style: kSubtitle2Style),
          ],
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/models/assigned_pickup_model.dart';
import 'package:scrap_it/screens/seller/trashPickup/data/pickup_statuses.dart';

class TrackPickupScreen extends StatelessWidget {
  final AssignedPickupModel pickup;

  const TrackPickupScreen({super.key, required this.pickup});

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
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      pickup.selectedLocation.latitude,
                      pickup.selectedLocation.longitude,
                    ),
                    zoom: 11.4746,
                  ),
                  markers: {
                    Marker(
                      markerId: const MarkerId('Pickup Location'),
                      position: LatLng(
                        pickup.selectedLocation.latitude,
                        pickup.selectedLocation.longitude,
                      ),
                      infoWindow: const InfoWindow(title: 'Pickup Location'),
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
                      Text('Pickup ID:', style: kTitle2LessEmphasis),
                      Text(pickup.id, style: kTitle2Style.copyWith(color: kPrimaryColor)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  StepProgressIndicator(
                    totalSteps: 4,
                    currentStep: int.parse(pickup.status) + 1,
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
                        Text(pickupStatuses[index], style: kSubtitle3Style, textAlign: TextAlign.center),
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: color,
                          child: Icon(UIcons.boldRounded.cross, size: 15, color: Colors.black),
                        ),
                        Text(pickupStatuses[index], style: kSubtitle3Style, textAlign: TextAlign.center),
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
                    subtitle: Text('${pickup.contactName}\n${pickup.contactNumber}', style: kSubtitleStyle),
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
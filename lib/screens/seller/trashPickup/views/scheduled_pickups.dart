import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/sharedWidgets/top_header_with_back.dart';
import 'package:scrap_it/screens/seller/trashPickup/controllers/scheduled_pickup_controller.dart';
import 'package:scrap_it/screens/seller/trashPickup/views/book_a_pickup.dart';
import 'package:scrap_it/screens/seller/trashPickup/views/track_pickup_booking.dart';
import 'package:intl/intl.dart';

class ScheduledPickupScreen extends StatelessWidget {
  const ScheduledPickupScreen({super.key, required this.backButtonVisible});
  final bool backButtonVisible;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        onPressed: () {
          Get.to(
            () => BookTrashPickupScreen(),
            transition: Transition.zoom,
          );
        },
        child: Icon(
          UIcons.regularRounded.calendar_plus,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GetX<ScheduledPickupController>(
              init: ScheduledPickupController(),
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    backButtonVisible
                        ? TopHeaderWithBackButton(title: 'Scheduled Pickups')
                        : Center(
                            child: Text(
                              'Scheduled Pickups',
                              style: kTitle2Style.copyWith(color: Colors.black),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    controller.isLoading.value
                        ? Center(
                            child: CircularProgressIndicator(
                              color: kPrimaryColor,
                            ),
                          )
                        : controller.scheduledPickups.isEmpty
                            ? Center(
                                child: Text(
                                  'No scheduled pickups',
                                  style: kSubtitleStyle,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: controller.scheduledPickups.length,
                                  itemBuilder: (context, index) {
                                    final pickup = controller.scheduledPickups[index];
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.05),
                                            blurRadius: 10,
                                            offset: const Offset(0, 4),
                                          ),
                                        ],
                                      ),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          onTap: () => Get.to(() => TrackPickupBookingScreen(
                                                pickupBooking: pickup,
                                              )),
                                          borderRadius: BorderRadius.circular(15),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(height: 16),
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding: const EdgeInsets.all(12),
                                                      decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                          colors: [
                                                            kPrimaryColor.withOpacity(0.1),
                                                            kPrimaryColor.withOpacity(0.2),
                                                          ],
                                                          begin: Alignment.topLeft,
                                                          end: Alignment.bottomRight,
                                                        ),
                                                        borderRadius: BorderRadius.circular(10),
                                                      ),
                                                      child: Icon(
                                                        UIcons.regularRounded.calendar,
                                                        color: kPrimaryColor,
                                                        size: 24,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Booking ID: ${pickup.id}',
                                                            style: kTitle3Style,
                                                          ),
                                                          const SizedBox(height: 4),
                                                          Text(
                                                            '${DateFormat('dd MMM yyyy').format(pickup.selectedDate.toDate())} at ${DateFormat('hh:mm a').format(pickup.selectedDate.toDate())}',
                                                            style: kSubtitleStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        // TODO: Implement cancel functionality
                                                      },
                                                      child: Container(
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: const Color(0xffFFF2F2),
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Icon(
                                                          UIcons.regularRounded.cross_small,
                                                          size: 20,
                                                          color: const Color(0xffEB455F),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
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

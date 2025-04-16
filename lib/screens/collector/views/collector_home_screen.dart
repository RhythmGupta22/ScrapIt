import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uicons/uicons.dart';
import 'package:scrap_it/constants/colors.dart';
import 'package:scrap_it/constants/fonts.dart';
import 'package:scrap_it/screens/collector/controllers/collector_profile_controller.dart';
import 'package:scrap_it/screens/collector/views/assigned_orders_screen.dart';
import 'package:scrap_it/screens/collector/views/assigned_pickups_screen.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';
import 'package:scrap_it/sharedWidgets/task_card.dart';

class CollectorHomeScreen extends StatelessWidget {
  const CollectorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CollectorProfileController>();
    final user = AuthRepository.instance.firebaseUser.value;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello,',
                              style: kSubtitleStyle.copyWith(
                                color: Colors.grey.shade600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Obx(() => Text(
                              controller.collectorName.value,
                              style: kTitleStyle.copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                            const SizedBox(height: 8),
                            Obx(() {
                              if (controller.isLoadingLocation.value) {
                                return Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Getting location...',
                                      style: kSubtitleStyle.copyWith(
                                        color: Colors.grey.shade600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (controller.locationError.value.isNotEmpty) {
                                return Text(
                                  controller.locationError.value,
                                  style: kSubtitleStyle.copyWith(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                );
                              } else if (controller.currentPosition.value != null) {
                                return Row(
                                  children: [
                                    Icon(
                                      UIcons.regularRounded.map_marker,
                                      size: 16,
                                      color: Colors.green,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      'Location updated',
                                      style: kSubtitleStyle.copyWith(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: kSecondaryColor,
                          backgroundImage: user?.photoURL != null 
                              ? NetworkImage(user!.photoURL!)
                              : null,
                          child: user?.photoURL == null
                              ? Icon(Icons.person, color: kPrimaryColor, size: 30)
                              : null,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Today\'s Tasks',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskCard(
                      title: 'Assigned Pickups',
                      icon: UIcons.regularRounded.boxes,
                      count: controller.assignedPickupsCount.toString(),
                      onTap: () => Get.to(() => const AssignedPickupsScreen()),
                    ),
                    const SizedBox(height: 12),
                    TaskCard(
                      title: 'Assigned Orders',
                      icon: UIcons.regularRounded.shopping_bag,
                      count: controller.assignedOrdersCount.toString(),
                      onTap: () => Get.to(() => const AssignedOrdersScreen()),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Statistics',
                      style: kTitle2Style.copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
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
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.green.withOpacity(0.1),
                                        Colors.green.withOpacity(0.2),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.green,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Completed',
                                  style: kSubtitleStyle.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Obx(() => Text(
                                  controller.completedTasksCount.toString(),
                                  style: kTitleStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(16),
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
                            child: Column(
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
                                    UIcons.regularRounded.clock,
                                    size: 24,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Pending',
                                  style: kSubtitleStyle.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Obx(() => Text(
                                  controller.pendingTasksCount.toString(),
                                  style: kTitleStyle.copyWith(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: kPrimaryColor,
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
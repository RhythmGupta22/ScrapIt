import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/api.dart';
import 'package:scrap_it/screens/collector/models/assigned_pickup_model.dart';
import 'package:scrap_it/screens/collector/repository/collector_repository.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';

class AssignedPickupsController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<AssignedPickupModel> assignedPickups = <AssignedPickupModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchAssignedPickups();
  }

  void fetchAssignedPickups() async {
    isLoading.value = true;
    String collectorId = AuthRepository.instance.firebaseUser.value!.uid;
    ApiResponse response = await CollectorRepository.instance.getAssignedPickups(collectorId);
    if (response.message == ApiMessage.success) {
      assignedPickups.value = response.data;
    } else {
      Get.snackbar('Error', 'Failed to fetch pickups', backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void updatePickupStatus(String pickupId, String newStatus) async {
    isLoading.value = true;
    ApiResponse response = await CollectorRepository.instance.updatePickupStatus(pickupId, newStatus);
    if (response.message == ApiMessage.success) {
      fetchAssignedPickups();
      Get.snackbar('Success', 'Status updated', backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to update status', backgroundColor: Colors.redAccent);
    }
    isLoading.value = false;
  }
}
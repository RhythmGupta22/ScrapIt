import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrap_it/constants/api.dart';
import 'package:scrap_it/screens/collector/models/assigned_order_model.dart';
import 'package:scrap_it/screens/collector/repository/collector_repository.dart';
import 'package:scrap_it/screens/login/repository/auth_repository.dart';

class AssignedOrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<AssignedOrderModel> assignedOrders = <AssignedOrderModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    fetchAssignedOrders();
  }

  void fetchAssignedOrders() async {
    isLoading.value = true;
    String collectorId = AuthRepository.instance.firebaseUser.value!.uid;
    ApiResponse response = await CollectorRepository.instance.getAssignedOrders(collectorId);
    if (response.message == ApiMessage.success) {
      assignedOrders.value = response.data;
    } else {
      Get.snackbar('Error', 'Failed to fetch orders', backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
    isLoading.value = false;
  }

  void updateOrderStatus(String orderId, String newStatus) async {
    isLoading.value = true;
    ApiResponse response = await CollectorRepository.instance.updateOrderStatus(orderId, newStatus);
    if (response.message == ApiMessage.success) {
      fetchAssignedOrders();
      Get.snackbar('Success', 'Status updated', backgroundColor: Colors.green);
    } else {
      Get.snackbar('Error', 'Failed to update status', backgroundColor: Colors.redAccent);
    }
    isLoading.value = false;
  }
}
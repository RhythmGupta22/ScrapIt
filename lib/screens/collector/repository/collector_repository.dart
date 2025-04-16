import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrap_it/constants/api.dart';
import 'package:scrap_it/constants/firebase_collections.dart';
import 'package:scrap_it/screens/collector/models/assigned_pickup_model.dart';
import 'package:scrap_it/screens/collector/models/assigned_order_model.dart';

class CollectorRepository {
  static final instance = CollectorRepository._();
  CollectorRepository._();

  Future<ApiResponse> getAssignedPickups(String collectorId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.ASSIGNED_PICKUPS)
          .where('collector_id', isEqualTo: collectorId)
          .get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      List<AssignedPickupModel> pickups = AssignedPickupModel.helper.fromMapArray(data);
      return ApiResponse(message: ApiMessage.success, data: pickups);
    } catch (e) {
      return ApiResponse(message: ApiMessage.somethingWantWrongError, data: []);
    }
  }

  Future<ApiResponse> getAssignedOrders(String collectorId) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.ASSIGNED_ORDERS)
          .where('collector_id', isEqualTo: collectorId)
          .get();
      final data = snapshot.docs.map((doc) => doc.data()).toList();
      List<AssignedOrderModel> orders = AssignedOrderModel.helper.fromMapArray(data);
      return ApiResponse(message: ApiMessage.success, data: orders);
    } catch (e) {
      return ApiResponse(message: ApiMessage.somethingWantWrongError, data: []);
    }
  }

  Future<ApiResponse> updatePickupStatus(String pickupId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.ASSIGNED_PICKUPS)
          .doc(pickupId)
          .update({'status': newStatus});
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.PICKUP_BOOKINGS)
          .doc(pickupId)
          .update({'status': newStatus});
      return ApiResponse(message: ApiMessage.success);
    } catch (e) {
      return ApiResponse(message: ApiMessage.somethingWantWrongError);
    }
  }

  Future<ApiResponse> updateOrderStatus(String orderId, String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.ASSIGNED_ORDERS)
          .doc(orderId)
          .update({'status': newStatus});
      await FirebaseFirestore.instance
          .collection(FirebaseCollections.ORDERS)
          .doc(orderId)
          .update({'status': newStatus});
      return ApiResponse(message: ApiMessage.success);
    } catch (e) {
      return ApiResponse(message: ApiMessage.somethingWantWrongError);
    }
  }
}
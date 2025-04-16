import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:scrap_it/constants/firebase_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  static FirebaseFunctions get instance => FirebaseFunctions();

  //* ------------------- AUTHENTICATION FUNCTIONS: ---------------------

  Future<void> createUserDocumentWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
    required String uid,
    String? role,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.USERS)
        .doc(uid)
        .set({
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'phoneNumber': null,
      'role': role, // Don't set default role here
    });
  }

  Future<void> createUserWithPhoneNumber({
    required String name,
    required String phoneNumber,
    required String uid,
    String? role,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.USERS)
        .doc(uid)
        .set({
      'name': name,
      'phoneNumber': phoneNumber,
      'uid': uid,
      'email': null,
      'role': role, // Don't set default role here
    });
  }

  Future<bool> checkIfPhoneNumberExists(String phoneNumber) async {
    bool exists = false;
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.USERS)
        .where('phoneNumber', isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        log("User exists");
        exists = true;
      } else {
        log("User does not exist");
      }
    });
    return exists;
  }

  //* New: Set or update user role
  Future<void> setUserRole({required String uid, required String role}) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.USERS)
        .doc(uid)
        .update({'role': role});
  }

  //* New: Get user role
  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection(FirebaseCollections.USERS)
          .doc(uid)
          .get();
      if (userDoc.exists) {
        return userDoc.get('role') as String?;
      }
      return null;
    } catch (e) {
      log('Error fetching role: $e');
      return null;
    }
  }

  //* ------------------- TRASH PICKUP FUNCTIONS: ---------------------
  Future<void> createPickupBooking({
    required DateTime selectedDate,
    required TimeOfDay selectedTimeSlot,
    required List<String> selectedWasteTypes,
    required String pickUpAddress,
    required LatLng selectedLocation,
    required String contactName,
    required String contactNumber,
    required String instructions,
    required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.PICKUP_BOOKINGS)
        .add({
      'selectedDate': selectedDate,
      'selectedTimeSlotString': DateFormat('hh:mm a').format(DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day,
          selectedTimeSlot.hour, selectedTimeSlot.minute)),
      'selectedWasteTypes': selectedWasteTypes,
      'pickUpAddress': pickUpAddress,
      'selectedLocation':
      GeoPoint(selectedLocation.latitude, selectedLocation.longitude),
      'instructions': instructions,
      'contactName': contactName,
      'contactNumber': contactNumber,
      'status': '0', // 0: Pending, 1: Assigned, 2: In Progress, 3: Completed
      'user_id': uid,
      'pickupPartner': {
        'partner_name': '',
        'partner_contact': '',
      }
    }).then((value) => {
      log('Pickup Booking Created'),
      FirebaseFirestore.instance
          .collection(FirebaseCollections.PICKUP_BOOKINGS)
          .doc(value.id)
          .update({'id': value.id})
    });
  }

  //* New: Assign pickup to a collector
  Future<void> assignPickupToCollector({
    required String pickupId,
    required String collectorId,
    required String collectorName,
    required String collectorContact,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.PICKUP_BOOKINGS)
        .doc(pickupId)
        .update({
      'status': '1', // Assigned
      'pickupPartner': {
        'partner_name': collectorName,
        'partner_contact': collectorContact,
      },
    });

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ASSIGNED_PICKUPS)
        .doc(pickupId)
        .set({
      'pickup_id': pickupId,
      'collector_id': collectorId,
      'status': '1', // Assigned
      'user_id': (await FirebaseFirestore.instance
          .collection(FirebaseCollections.PICKUP_BOOKINGS)
          .doc(pickupId)
          .get())
          .get('user_id'),
      'assigned_at': FieldValue.serverTimestamp(),
    });
  }

  //* New: Update pickup status
  Future<void> updatePickupStatus({
    required String pickupId,
    required String newStatus,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.PICKUP_BOOKINGS)
        .doc(pickupId)
        .update({'status': newStatus});

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ASSIGNED_PICKUPS)
        .doc(pickupId)
        .update({'status': newStatus});
  }

  //* ------------------- SUBMIT FEEDBACK FUNCTIONS: ---------------------

  Future<void> submitFeedback({
    required String subject,
    required String feedback,
    required String uid,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.FEEDBACK)
        .add({
      'subject': subject,
      'feedback': feedback,
      'user_id': uid,
    });
  }

  //* ----------------------- SHOP RELATED FUNCTIONS: -----------------------
  // Future<void> setupInitialStore({required List<ShopItemModel> shopItems}) async{
  //   await FirebaseFirestore.instance
  //       .collection(FirebaseCollections.SHOP_ITEMS)
  //       .get()
  //       .then((value) {
  //     if (value.docs.isEmpty) {
  //       shopItems.forEach((element) async {
  //         await FirebaseFirestore.instance
  //             .collection(FirebaseCollections.SHOP_ITEMS)
  //             .add({
  //           'name': element.name,
  //           'description': element.description,
  //           'imageUrl': element.imageUrl,
  //           'price': element.price,
  //           'category': element.category,
  //           'id': element.id,
  //         });
  //       });
  //     }
  //   });
  // }

  Future<String> getUserName({required String uid}) async {
    String name = '';
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.USERS)
        .doc(uid)
        .get()
        .then((value) {
      if (value.exists) {
        name = value.data()!['name'];
      }
    });
    return name;
  }

  //* New: Assign order to a collector
  Future<void> assignOrderToCollector({
    required String orderId,
    required String collectorId,
    required String collectorName,
    required String collectorContact,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ORDERS)
        .doc(orderId)
        .update({
      'status': '1', // Assigned
      'deliveryPartner': {
        'partner_name': collectorName,
        'partner_contact': collectorContact,
      },
    });

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ASSIGNED_ORDERS)
        .doc(orderId)
        .set({
      'order_id': orderId,
      'collector_id': collectorId,
      'status': '1', // Assigned
      'user_id': (await FirebaseFirestore.instance
          .collection(FirebaseCollections.ORDERS)
          .doc(orderId)
          .get())
          .get('user_id'),
      'assigned_at': FieldValue.serverTimestamp(),
    });
  }

  //* New: Update order status
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ORDERS)
        .doc(orderId)
        .update({'status': newStatus});

    await FirebaseFirestore.instance
        .collection(FirebaseCollections.ASSIGNED_ORDERS)
        .doc(orderId)
        .update({'status': newStatus});
  }

  Future<int> getAssignedPickupsCount(String collectorId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.PICKUP_BOOKINGS)
          .where('collector_id', isEqualTo: collectorId)
          .where('status', isEqualTo: '1')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Error getting assigned pickups count: $e');
      return 0;
    }
  }

  Future<int> getAssignedOrdersCount(String collectorId) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.ORDERS)
          .where('collector_id', isEqualTo: collectorId)
          .where('status', isEqualTo: '1')
          .get();
      return snapshot.docs.length;
    } catch (e) {
      print('Error getting assigned orders count: $e');
      return 0;
    }
  }

  Future<int> getCompletedTasksCount(String collectorId) async {
    try {
      final pickupsSnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.PICKUP_BOOKINGS)
          .where('collector_id', isEqualTo: collectorId)
          .where('status', isEqualTo: '3')
          .get();

      final ordersSnapshot = await FirebaseFirestore.instance
          .collection(FirebaseCollections.ORDERS)
          .where('collector_id', isEqualTo: collectorId)
          .where('status', isEqualTo: '3')
          .get();

      return pickupsSnapshot.docs.length + ordersSnapshot.docs.length;
    } catch (e) {
      print('Error getting completed tasks count: $e');
      return 0;
    }
  }
}
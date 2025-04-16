import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrap_it/utils/helper_model.dart';

class AssignedPickupModel {
  final String instructions;
  final String userId;
  final String pickUpAddress;
  final String selectedTimeSlotString;
  final Timestamp selectedDate;
  final List<String> selectedWasteTypes;
  final GeoPoint selectedLocation;
  final String status;
  final String id;
  final String contactName;
  final String contactNumber;

  AssignedPickupModel({
    required this.instructions,
    required this.userId,
    required this.pickUpAddress,
    required this.selectedTimeSlotString,
    required this.selectedDate,
    required this.selectedWasteTypes,
    required this.selectedLocation,
    required this.status,
    required this.id,
    required this.contactName,
    required this.contactNumber,
  });

  static final helper = HelperModel(
        (map) => AssignedPickupModel.fromMap(map),
  );

  AssignedPickupModel copyWith({
    String? instructions,
    String? userId,
    String? pickUpAddress,
    String? selectedTimeSlotString,
    Timestamp? selectedDate,
    List<String>? selectedWasteTypes,
    GeoPoint? selectedLocation,
    String? status,
    String? id,
    String? contactName,
    String? contactNumber,
  }) {
    return AssignedPickupModel(
      instructions: instructions ?? this.instructions,
      userId: userId ?? this.userId,
      pickUpAddress: pickUpAddress ?? this.pickUpAddress,
      selectedTimeSlotString: selectedTimeSlotString ?? this.selectedTimeSlotString,
      selectedDate: selectedDate ?? this.selectedDate,
      selectedWasteTypes: selectedWasteTypes ?? this.selectedWasteTypes,
      selectedLocation: selectedLocation ?? this.selectedLocation,
      status: status ?? this.status,
      id: id ?? this.id,
      contactName: contactName ?? this.contactName,
      contactNumber: contactNumber ?? this.contactNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'instructions': instructions,
      'user_id': userId,
      'pickUpAddress': pickUpAddress,
      'selectedTimeSlotString': selectedTimeSlotString,
      'selectedDate': selectedDate,
      'selectedWasteTypes': selectedWasteTypes,
      'selectedLocation': selectedLocation,
      'status': status,
      'id': id,
      'contactName': contactName,
      'contactNumber': contactNumber,
    };
  }

  factory AssignedPickupModel.fromMap(Map<String, dynamic> map) {
    return AssignedPickupModel(
      instructions: map['instructions'] ?? '',
      userId: map['user_id'] ?? '',
      pickUpAddress: map['pickUpAddress'] ?? '',
      selectedTimeSlotString: map['selectedTimeSlotString'] ?? '',
      selectedDate: map['selectedDate'] ?? Timestamp.now(),
      selectedWasteTypes: List<String>.from(map['selectedWasteTypes'] ?? []),
      selectedLocation: map['selectedLocation'] ?? GeoPoint(0, 0),
      status: map['status'] ?? '0',
      id: map['id'] ?? '',
      contactName: map['contactName'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedPickupModel.fromJson(String source) => AssignedPickupModel.fromMap(json.decode(source));

  @override
  String toString() => 'AssignedPickupModel(id: $id, status: $status)';
}
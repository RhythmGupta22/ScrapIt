import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scrap_it/utils/helper_model.dart';

import '../../seller/viewShopOrders/model/user_order_model.dart';

class AssignedOrderModel {
  final String userId;
  final String deliveryAddress;
  final String paymentOption;
  final List<Item> items;
  final String id;
  final Timestamp timestamp;
  final String contactName;
  final String contactNumber;
  final String status;

  AssignedOrderModel({
    required this.userId,
    required this.deliveryAddress,
    required this.paymentOption,
    required this.items,
    required this.id,
    required this.timestamp,
    required this.contactName,
    required this.contactNumber,
    required this.status,
  });

  static final helper = HelperModel(
        (map) => AssignedOrderModel.fromMap(map),
  );

  AssignedOrderModel copyWith({
    String? userId,
    String? deliveryAddress,
    String? paymentOption,
    List<Item>? items,
    String? id,
    Timestamp? timestamp,
    String? contactName,
    String? contactNumber,
    String? status,
  }) {
    return AssignedOrderModel(
      userId: userId ?? this.userId,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentOption: paymentOption ?? this.paymentOption,
      items: items ?? this.items,
      id: id ?? this.id,
      timestamp: timestamp ?? this.timestamp,
      contactName: contactName ?? this.contactName,
      contactNumber: contactNumber ?? this.contactNumber,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'deliveryAddress': deliveryAddress,
      'paymentOption': paymentOption,
      'items': items.map((x) => x.toMap()).toList(),
      'id': id,
      'timestamp': timestamp,
      'contactName': contactName,
      'contactNumber': contactNumber,
      'status': status,
    };
  }

  factory AssignedOrderModel.fromMap(Map<String, dynamic> map) {
    return AssignedOrderModel(
      userId: map['user_id'] ?? '',
      deliveryAddress: map['deliveryAddress'] ?? '',
      paymentOption: map['paymentOption'] ?? '',
      items: List<Item>.from(map['items']?.map((x) => Item.fromMap(x)) ?? []),
      id: map['id'] ?? '',
      timestamp: map['timestamp'] ?? Timestamp.now(),
      contactName: map['contactName'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
      status: map['status'] ?? '0',
    );
  }

  String toJson() => json.encode(toMap());

  factory AssignedOrderModel.fromJson(String source) => AssignedOrderModel.fromMap(json.decode(source));

  @override
  String toString() => 'AssignedOrderModel(id: $id, status: $status)';
}
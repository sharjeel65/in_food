import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  late String orderId;
  late String restaurantId;
  late List<Map<String, dynamic>> items;
  late String status;
  late String eta;
  late String paymentMethod;
  late String address;
  late String reason;
  late String userId;
  late String startTime;
  late String endTime;
  late double? total;
  late double? lat;
  late double? lng;

  OrderModel({
    required this.restaurantId,
    required this.items,
    required this.status,
    required this.eta,
    required this.paymentMethod,
    required this.address,
    required this.orderId,
    required this.reason,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.total,
    required this.lat,
    required this.lng,
  });

  OrderModel.fromMap(Map<String, dynamic> map)
      : restaurantId = map['restaurantId'],
        userId = map['userId'],
        items = List<Map<String, dynamic>>.from(map['items']),
        status = map['status'],
        eta = map['eta'],
        address = map['address'],
        orderId = map['orderId'],
        reason = map['reason'],
        startTime = map['startTime'],
        endTime = map['endTime'],
        total = map['total'],
        lat = map['lat'],
        lng = map['lng'],
        paymentMethod = map['paymentMethod'];

  Map<String, dynamic> toMap() {
    return {
      'restaurantId': restaurantId,
      'items': items,
      'userId': userId,
      'status': status,
      'eta': eta,
      'address': address,
      'orderId': orderId,
      'reason': reason,
      'startTime': startTime,
      'endTime': endTime,
      'total': total,
      'lat': lat,
      'lng': lng,
      'paymentMethod': paymentMethod,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

    return OrderModel(
      restaurantId: data?['restaurantId'] ?? '',
      reason: data?['reason'] ?? '',
      userId: data?['userId'] ?? '',
      orderId: data?['orderId'] ?? '',
      items: List<Map<String, dynamic>>.from(data?['items'] ?? []),
      status: data?['status'] ?? '',
      eta: data?['eta'] ?? '0',
      startTime: data?['startTime'] ?? '',
      endTime: data?['endTime'] ?? '',
      address: data?['address'] ?? '',
      total: data?['total'] ?? 0,
      lat: data?['lat'] ?? 0,
      lng: data?['lng'] ?? 0,
      paymentMethod: data?['paymentMethod'] ?? '',
    );
  }
}

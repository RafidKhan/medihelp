import 'package:medihelp/models/order_model.dart';

class OrderHistoryModel {
  final String orderId;
  final String orderBy;
  final int totalPrice;
  final List<OrderModel> orderData;

  OrderHistoryModel({
    required this.orderId,
    required this.orderBy,
    required this.orderData,
    required this.totalPrice,
  });

  OrderHistoryModel.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'] ?? [],
        orderBy = json['order_by'] ?? [],
        totalPrice = json['totalPrice'] ?? 0,
        orderData = json['order_data'] ?? [];

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'order_by': orderBy,
        'order_data': orderData,
        'totalPrice': totalPrice,
      };
}

class OrderModel {
  final String orderId;
  final String orderBy;
  final String orderStatus;
  final int totalPrice;
  final List<dynamic> orderData;

  OrderModel({
    required this.orderId,
    required this.orderBy,
    required this.orderData,
    required this.totalPrice,
    required this.orderStatus,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'] ?? "",
        orderBy = json['order_by'] ?? "",
        totalPrice = json['total_price'] ?? 0,
        orderData = json['order_data'] ?? [],
        orderStatus = json['order_status'] ?? [];

  Map<String, dynamic> toJson() => {
        'order_id': orderId,
        'order_by': orderBy,
        'order_data': orderData,
        'totalPrice': totalPrice,
        'order_status': orderStatus,
      };
}

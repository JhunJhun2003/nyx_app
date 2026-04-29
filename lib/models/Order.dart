import 'dart:io';

class OrderItem {
  final int productId;
  final int quantity;
  
  OrderItem({
    required this.productId,
    required this.quantity,
  });
  
  Map<String, dynamic> toJson() => {
    'product_id': productId,
    'quantity': quantity,
  };
}

class OrderRequest {
  final int userId;
  final String customerName;
  final String phone;
  final String email;
  final String deliveryAddress;
  final String remark;
  final String paymentMethod;
  final List<OrderItem> items;
  final double tax;
  final double deliveryFee;
  final File? transactionImage;
  final String? transactionNumber;
  
  OrderRequest({
    required this.userId,
    required this.customerName,
    required this.phone,
    required this.email,
    required this.deliveryAddress,
    required this.remark,
    required this.paymentMethod,
    required this.items,
    required this.tax,
    required this.deliveryFee,
    this.transactionImage,
    this.transactionNumber,
  });
}
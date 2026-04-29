import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:nyxproject/Util/Constant.dart';

class OrderApi {
  // Place order
static Future<Map<String, dynamic>> placeOrder({
  required int userId,
  required String customerName,
  required String phone,
  required String email,
  required String deliveryAddress,
  required String remark,
  required String paymentMethod,
  required List<Map<String, dynamic>> items,
  required double tax,
  required double deliveryFee,
  File? transactionImage,
  String? transactionNumber,
  String? token,
}) async {
  final Uri uri = Uri.parse("${Constant.API_URL}/cart/order");
  
  final request = http.MultipartRequest('POST', uri);
  
  if (token != null && token.isNotEmpty) {
    request.headers['Authorization'] = 'Bearer $token';
  }
  request.headers['Accept'] = 'application/json';
  
  request.fields['user_id'] = userId.toString();
  request.fields['customer_name'] = customerName;
  request.fields['phone'] = phone;
  request.fields['email'] = email;
  request.fields['delivery_address'] = deliveryAddress;
  request.fields['remark'] = remark;
  request.fields['payment_method'] = paymentMethod;
  request.fields['items'] = jsonEncode(items);  // ✅ Convert to JSON string
  request.fields['tax'] = tax.toString();
  request.fields['delivery_fee'] = deliveryFee.toString();
  
  if (transactionNumber != null && transactionNumber.isNotEmpty) {
    request.fields['transaction_number'] = transactionNumber;
  }
  
  if (transactionImage != null) {
    request.files.add(
      await http.MultipartFile.fromPath('image', transactionImage.path),
    );
  }
  
  final streamedResponse = await request.send();
  final response = await http.Response.fromStream(streamedResponse);
  
  if (response.statusCode == 200 || response.statusCode == 201) {
    return {
      'success': true,
      'data': jsonDecode(response.body),
      'message': 'Order placed successfully',
    };
  } else {
    return {
      'success': false,
      'message': 'Failed to place order',
    };
  }
}
}

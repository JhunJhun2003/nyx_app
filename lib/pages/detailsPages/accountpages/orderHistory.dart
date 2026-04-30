import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/Util/OrderApi.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/slip.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({super.key});

  @override
  State<orderHistory> createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  final List<String> statusFilter = [
    "All",
    "Pending",
    "Delivered",
    "Cancelled",
  ];

  String _selectedStatus = "All";
  List<dynamic> _orders = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final sessionService = Provider.of<SessionService>(
        context,
        listen: false,
      );
      final user = sessionService.getStoredUser();
      final userId = user?.id ?? 0;
      final token = sessionService.getToken();

      if (userId == 0) {
        setState(() {
          _errorMessage = 'Please login to view orders';
          _isLoading = false;
        });
        return;
      }

      final result = await OrderApi.fetchOrders(userId: userId, token: token);

      if (result['success']) {
        setState(() {
          _orders = result['data'] ?? [];
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = result['message'] ?? 'Failed to load orders';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  String _formatDate(String? dateTimeString) {
    if (dateTimeString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateTimeString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateTimeString;
    }
  }

  void _navigateToSlipPage(Map<String, dynamic> order) {
    // Extract order details
    final orderId = order['order_id']?.toString() ?? 'N/A';
    final orderDate = order['create_at']?.toString() ?? '';
    final orderItems = order['items'] ?? [];
    final subTotal = order['Sub_total'] ?? 0;
    final tax = order['tax'] ?? 0;
    final deliveryFee = order['delivery_fee'] ?? 0;
    final total = order['Total'] ?? 0;
    final paymentMethod =
        order['payment_method']?.toString() ?? 'Cash on Delivery';

    // ✅ Convert to Map<String, String> explicitly
    final contactInfo = <String, String>{
      'name': order['customer_name']?.toString() ?? 'N/A',
      'phone': order['phone']?.toString() ?? 'N/A',
      'email': order['email']?.toString() ?? 'N/A',
      'address': order['delivery_address']?.toString() ?? 'N/A',
      'remark': order['remark']?.toString() ?? '',
    };

    // Navigate to slip page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => slipPage(
          paymentMethod: paymentMethod,
          transactionNumber: order['transaction_number']?.toString(),
          totalAmount: total is int
              ? total.toDouble()
              : (total as double? ?? 0.0),
          contactInfo: contactInfo, // ✅ Now it's Map<String, String>
          orderResponse: order,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            const SizedBox(height: 10),
            _filterBar(),
            const SizedBox(height: 10),
            Expanded(child: _buildContent()),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading orders...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(_errorMessage!),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchOrders,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (_orders.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('No orders found'),
            SizedBox(height: 8),
            Text(
              'Your order history will appear here',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];

        final orderId = order['order_id']?.toString() ?? '#${index + 1}';
        final date = _formatDate(order['create_at']);
        final total = order['Total']?.toString() ?? '0';
        final itemCount = order['items']?.length ?? 0;

        return _orderCard(
          order: order,
          orderId: orderId,
          date: date,
          total: total,
          itemCount: itemCount,
          onTap: () => _navigateToSlipPage(order),
        );
      },
    );
  }

  Widget _header() {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          const Expanded(
            child: Text(
              "Orders History",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _filterBar() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: statusFilter.length,
        itemBuilder: (context, index) {
          final status = statusFilter[index];
          final isSelected = status == _selectedStatus;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedStatus = status;
              });
              _fetchOrders();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF0D1B2A)
                    : Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  status,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _orderCard({
    required Map<String, dynamic> order,
    required String orderId,
    required String date,
    required String total,
    required int itemCount,
    required VoidCallback onTap,
  }) {
    // Determine status color (you can add status field to your API)
    Color statusColor = Colors.orange; // Default pending
    String statusText = "Pending";

    // If your API has status field, use it
    if (order['status'] != null) {
      switch (order['status'].toString().toLowerCase()) {
        case 'delivered':
        case 'completed':
          statusColor = Colors.green;
          statusText = "Delivered";
          break;
        case 'cancelled':
          statusColor = Colors.red;
          statusText = "Cancelled";
          break;
        default:
          statusColor = Colors.orange;
          statusText = "Pending";
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Order Icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF0D1B2A),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.receipt_long,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            // Order Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Order #$orderId",
                        style: const TextStyle(
                          fontFamily: "Custom",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          statusText,
                          style: TextStyle(
                            fontFamily: "Custom",
                            color: statusColor,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        date,
                        style: const TextStyle(
                          fontFamily: "Custom",
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.shopping_bag,
                        size: 12,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$itemCount items',
                        style: const TextStyle(
                          fontFamily: "Custom",
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 4),
                  // Text(
                  //   "$total Ks",
                  //   style: const TextStyle(
                  //     fontFamily: "Custom",
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 14,
                  //     color: Colors.red,
                  //   ),
                  // ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:nyxproject/pages/main_dashboard.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'package:nyxproject/services/session_service.dart';

class slipPage extends StatefulWidget {
  final String? paymentMethod;
  final String? transactionNumber;
  final double? totalAmount;
  final List<CartItem>? cartItems;
  final Map<String, String>? contactInfo;
  final Map<String, dynamic>? orderResponse; // ✅ Add this

  const slipPage({
    super.key,
    this.paymentMethod,
    this.transactionNumber,
    this.totalAmount,
    this.cartItems,
    this.contactInfo,
    this.orderResponse, // ✅ Add this
  });

  @override
  State<slipPage> createState() => _slipPageState();
}

class _slipPageState extends State<slipPage> {
  String orderNo =
      "#" + DateTime.now().millisecondsSinceEpoch.toString().substring(8, 13);
  String date =
      DateTime.now().day.toString().padLeft(2, '0') +
      "/" +
      DateTime.now().month.toString().padLeft(2, '0') +
      "/" +
      DateTime.now().year.toString();
  String time =
      DateTime.now().hour.toString().padLeft(2, '0') +
      ":" +
      DateTime.now().minute.toString().padLeft(2, '0');

  double subTotal = 0;
  double tax = 0;
  double deliveryFee = 1500;
  double total = 0;

  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    if (widget.cartItems != null && widget.cartItems!.isNotEmpty) {
      subTotal = widget.cartItems!.fold(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
    } else if (widget.totalAmount != null) {
      subTotal = widget.totalAmount!;
    } else {
      subTotal = 100000;
    }

    tax = subTotal * 0.05;
    total = subTotal + tax + deliveryFee;
  }

  @override
  Widget build(BuildContext context) {
    // Use orderResponse if available, otherwise use local data
    final orderNumber = widget.orderResponse?['order_number'] ?? orderNo;
    final orderDate = widget.orderResponse?['order_date'] ?? date;
    final orderTime = widget.orderResponse?['order_time'] ?? time;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 15),
              _voucher(orderNumber, orderDate, orderTime),
              const SizedBox(height: 15),
              _buttons(),
            ],
          ),
        ),
      ),
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
              "Order Confirmation",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _voucher(String orderNumber, String orderDate, String orderTime) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Center(
            child: Text(
              "Order Placed Successfully!",
              style: TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 51, 252, 57),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 5),
          const Center(
            child: Text(
              "Thank you for shopping with us.",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Delivery Information
          if (widget.contactInfo != null) ...[
            _infoRow("Name:", widget.contactInfo!['name'] ?? 'N/A'),
            const SizedBox(height: 8),
            _infoRow("Phone:", widget.contactInfo!['phone'] ?? 'N/A'),
            const SizedBox(height: 8),
            _infoRow("Email:", widget.contactInfo!['email'] ?? 'N/A'),
            const SizedBox(height: 8),
            _infoRow("Address:", widget.contactInfo!['address'] ?? 'N/A'),
            const SizedBox(height: 15),
            const Divider(color: Colors.white54),
            const SizedBox(height: 10),
          ],
          _infoRow("Order No :", orderNumber),
          const SizedBox(height: 8),
          _infoRow("Date :", orderDate),
          const SizedBox(height: 8),
          _infoRow("Time :", orderTime),
          const SizedBox(height: 8),
          _infoRow("Payment :", widget.paymentMethod ?? "Cash on Delivery"),
          if (widget.transactionNumber != null &&
              widget.transactionNumber!.isNotEmpty)
            _infoRow("Transaction No :", widget.transactionNumber!),
          const SizedBox(height: 15),
          const Divider(color: Colors.white54),
          const SizedBox(height: 10),
          const Text(
            "Order Items",
            style: TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          _productHeader(),
          const SizedBox(height: 5),
          _productList(),
          const SizedBox(height: 10),
          const Divider(color: Colors.white54),
          const SizedBox(height: 10),
          _priceRow("Sub Total :", "${subTotal.toStringAsFixed(0)} Ks"),
          _priceRow("Tax (5%) :", "${tax.toStringAsFixed(0)} Ks"),
          _priceRow("Delivery Fee :", "${deliveryFee.toStringAsFixed(0)} Ks"),
          const SizedBox(height: 8),
          const Divider(color: Colors.white54),
          _priceRow("Total :", "${total.toStringAsFixed(0)} Ks", isBold: true),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: "Custom",
            color: Colors.white70,
            fontSize: 15,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _productHeader() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Product - takes most space
          Expanded(
            flex: 3,
            child: Text(
              "Product",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Qty - fixed width
          SizedBox(
            width: 45,
            child: Text(
              "Qty",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Price - fixed width
          SizedBox(
            width: 80,
            child: Text(
              "Price",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productList() {
    if (widget.cartItems != null && widget.cartItems!.isNotEmpty) {
      return Column(
        children: widget.cartItems!.map((item) {
          return _productRow(
            item.product.productName,
            item.quantity.toString(),
            (item.product.price * item.quantity).toStringAsFixed(0),
          );
        }).toList(),
      );
    }

    return Column(
      children: [
        _productRow("Badminton Shuttlecock", "2", "9,000"),
        _productRow("Football", "1", "35,000"),
        _productRow("Tennis Racket", "1", "45,000"),
      ],
    );
  }

  Widget _productRow(String name, String qty, String price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          // Product Name - takes 60% of space
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Quantity - centered
          SizedBox(
            width: 40,
            child: Text(
              qty,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // Price - aligned right
          SizedBox(
            width: 80,
            child: Text(
              "$price Ks",
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String amount, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: "Custom",
              color: isBold ? Colors.white : Colors.white70,
              fontSize: isBold ? 16 : 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontFamily: "Custom",
              color: isBold
                  ? const Color.fromARGB(255, 51, 252, 57)
                  : Colors.white,
              fontSize: isBold ? 18 : 15,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 13, 27, 42),
                iconColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.home, size: 22),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainDashboard(
                      sessionService: SessionService(),
                      cartService: CartService(),
                    ),
                  ),
                  (route) => false,
                );
              },
              label: const Text(
                "Home",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Custom',
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                iconColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.file_download_outlined, size: 22),
              onPressed: () {
                _showDownloadDialog();
              },
              label: const Text(
                "Download",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Custom',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDownloadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Download Receipt"),
        content: const Text("Would you like to download your order receipt?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Receipt downloaded successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text("Download"),
          ),
        ],
      ),
    );
  }
}

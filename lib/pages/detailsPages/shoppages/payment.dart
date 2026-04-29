import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nyxproject/Util/Constant.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/slip.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/Util/OrderApi.dart';

class Payment extends StatefulWidget {
  final double? totalAmount;
  final Map<String, String>? contactInfo;

  const Payment({super.key, this.totalAmount, this.contactInfo});

  @override
  State<Payment> createState() => _PaymentState();
}

List<String> options = [
  "Cash on Delivery",
  "CB Pay",
  "Kpay",
  "WavePay",
  "Credit",
  "Other",
];

class _PaymentState extends State<Payment> {
  String currentOption = options[0];
  final TextEditingController input = TextEditingController();
  File? _transactionImage;
  bool _isProcessing = false;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Upload Transaction Slip',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.camera_alt, size: 28),
              title: const Text('Take a Photo'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImageFromCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library, size: 28),
              title: const Text('Choose from Gallery'),
              onTap: () async {
                Navigator.pop(context);
                await _pickImageFromGallery();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _transactionImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _transactionImage = File(image.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalAmount = widget.totalAmount ?? 100000.0;

    final contactInfo =
        widget.contactInfo ??
        {
          'name': 'N/A',
          'phone': 'N/A',
          'email': 'N/A',
          'address': 'N/A',
          'remark': 'N/A',
        };

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 5),
              _section("Contact Information"),
              const SizedBox(height: 5),
              _information("Name", contactInfo['name'] ?? 'N/A'),
              const SizedBox(height: 5),
              _information("Phone Number", contactInfo['phone'] ?? 'N/A'),
              const SizedBox(height: 5),
              _information("Email Address", contactInfo['email'] ?? 'N/A'),
              const SizedBox(height: 5),
              _information("Delivery Address", contactInfo['address'] ?? 'N/A'),
              const SizedBox(height: 10),
              _information("Remark", contactInfo['remark'] ?? 'N/A'),
              const SizedBox(height: 10),
              const Divider(),
              _information1(
                "Total Amount",
                "${totalAmount.toStringAsFixed(0)} Ks",
              ),
              const Divider(),
              _section("Select Payment Method"),
              const SizedBox(height: 5),
              _paymentMethod(),
              const SizedBox(height: 5),
              _paymentInfo(),
              const SizedBox(height: 10),
              if (_showTransactionInput()) ...[
                // _input("Enter transaction number (optional)"),
                // const SizedBox(height: 10),
                _imageUploadSection(),
              ],
              const SizedBox(height: 20),
              _confirm(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  bool _showTransactionInput() {
    return currentOption != "Cash on Delivery";
  }

  Widget _imageUploadSection() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Transaction Slip:",
                style: TextStyle(
                  fontFamily: 'Custom',
                  color: Color.fromARGB(255, 13, 27, 42),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.upload_file, size: 18),
                label: const Text("Upload Slip"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 13, 27, 42),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (_transactionImage != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    _transactionImage!,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton.icon(
                      onPressed: () => _pickImage(),
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text("Change"),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _transactionImage = null;
                        });
                      },
                      icon: const Icon(Icons.delete, size: 18),
                      label: const Text("Remove"),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
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
              "Payment",
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

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          color: Color.fromARGB(255, 13, 27, 42),
          fontWeight: FontWeight.w600,
          fontFamily: 'Custom',
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _information(String right, String left) {
    return Container(
      height: 30,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            right,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w500,
              fontFamily: 'Custom',
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Text(
              left,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: Color.fromARGB(255, 13, 27, 42),
                fontWeight: FontWeight.w500,
                fontFamily: 'Custom',
                fontSize: 15,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _information1(String right, String left) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            right,
            style: const TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontWeight: FontWeight.w700,
              fontFamily: 'Custom',
              fontSize: 17,
            ),
          ),
          Text(
            left,
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w700,
              fontFamily: 'Custom',
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentMethod() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: options.map((option) {
          return ListTile(
            title: Text(
              option,
              style: const TextStyle(
                fontFamily: 'Custom',
                color: Color.fromARGB(255, 13, 27, 42),
              ),
            ),
            leading: Radio(
              value: option,
              groupValue: currentOption,
              onChanged: (value) {
                setState(() {
                  currentOption = value.toString();
                  input.clear();
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _paymentInfo() {
    if (currentOption == "Cash on Delivery") {
      return const SizedBox.shrink();
    }

    Map<String, String> paymentDetails = {};

    switch (currentOption) {
      case "Kpay":
        paymentDetails = {
          'name': 'Nyx Sports Shop',
          'number': '09 123 456 789',
        };
        break;
      case "CB Pay":
        paymentDetails = {
          'name': 'Nyx Sports Shop',
          'number': '09 987 654 321',
        };
        break;
      case "WavePay":
        paymentDetails = {
          'name': 'Nyx Sports Shop',
          'number': '09 456 789 123',
        };
        break;
      default:
        paymentDetails = {
          'name': 'Nyx Sports Shop',
          'number': '09 123 456 789',
        };
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Account Name : ",
                style: TextStyle(
                  fontFamily: 'Custom',
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                paymentDetails['name'] ?? 'N/A',
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Account Number : ",
                style: TextStyle(
                  fontFamily: 'Custom',
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                paymentDetails['number'] ?? 'N/A',
                style: const TextStyle(
                  fontFamily: 'Custom',
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _input(String text) {
    return Center(
      child: Container(
        height: 50,
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: input,
          style: const TextStyle(
            fontFamily: "Custom",
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          decoration: InputDecoration(
            hintText: text,
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: const Color.fromARGB(255, 13, 27, 42),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ),
    );
  }

  Widget _confirm() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          fixedSize: const Size(200, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: _isProcessing ? null : _processOrder,
        child: _isProcessing
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Confirm Payment",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 16,
                ),
              ),
      ),
    );
  }

  Future<void> _processOrder() async {
    // For non-cash payments, require image upload
    if (_showTransactionInput()) {
      if (_transactionImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload transaction slip'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
        return;
      }
    }

    setState(() {
      _isProcessing = true;
    });

    try {
      final cartService = Provider.of<CartService>(context, listen: false);
      final sessionService = Provider.of<SessionService>(
        context,
        listen: false,
      );

      final user = sessionService.getStoredUser();
      final userId = user?.id ?? 0;
      final token = sessionService.getToken();

      if (userId == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User not found. Please login again.'),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          _isProcessing = false;
        });
        return;
      }

      // Prepare order items
      final itemsList = cartService.items.map((item) {
        return {'product_id': item.product.id, 'quantity': item.quantity};
      }).toList();

      // Convert items to JSON string
      final itemsJsonString = jsonEncode(itemsList);

      print("========== ORDER DETAILS ==========");
      print("User ID: $userId");
      print("Items List: $itemsList");
      print("Items JSON String: $itemsJsonString");
      print("===================================");

      final tax = cartService.totalPrice * 0.05;
      final deliveryFee = 5000.0;
      final contactInfo = widget.contactInfo ?? {};

      // Create multipart request
      final Uri uri = Uri.parse("${Constant.API_URL}/cart/order");
      final request = http.MultipartRequest('POST', uri);

      // Add headers
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      request.headers['Accept'] = 'application/json';

      // Add fields - matching Postman exactly
      request.fields['user_id'] = userId.toString();
      request.fields['customer_name'] = contactInfo['name'] ?? '';
      request.fields['phone'] = contactInfo['phone'] ?? '';
      request.fields['email'] = contactInfo['email'] ?? '';
      request.fields['delivery_address'] = contactInfo['address'] ?? '';
      request.fields['remark'] = contactInfo['remark'] ?? '';
      request.fields['payment_method'] = currentOption.toLowerCase();
      request.fields['items'] = itemsJsonString;
      request.fields['tax'] = tax.toString();
      request.fields['delivery_fee'] = deliveryFee.toString();

      if (input.text.trim().isNotEmpty) {
        request.fields['transaction_number'] = input.text.trim();
      }

      // Add image if uploaded
      if (_transactionImage != null) {
        request.files.add(
          await http.MultipartFile.fromPath('image', _transactionImage!.path),
        );
      }

      print("📤 Request Fields:");
      request.fields.forEach((key, value) {
        print("  $key: $value");
      });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      print("📥 Response Status: ${response.statusCode}");
      print("📥 Response Body: ${response.body}");

      setState(() {
        _isProcessing = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);

        // Clear cart after successful order
        cartService.clearCart();

        // Navigate to slip page
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => slipPage(
                paymentMethod: currentOption,
                transactionNumber: input.text.trim(),
                totalAmount: widget.totalAmount,
                contactInfo: widget.contactInfo,
                orderResponse: responseData,
              ),
            ),
          );
        }
      } else {
        String errorMessage = 'Failed to place order';
        String errorTitle = 'Order Failed';

        try {
          final responseBody = response.body;

          // Check for stock error
          if (responseBody.contains('Not enough stock')) {
            // Extract product ID from error message
            final productIdMatch = RegExp(
              r'product ID: (\d+)',
            ).firstMatch(responseBody);
            final productId = productIdMatch?.group(1) ?? 'unknown';

            // Find product name
            final outOfStockProduct = cartService.items.firstWhere(
              (item) => item.product.id.toString() == productId,
              orElse: () => cartService.items.first,
            );

            errorTitle = 'Out of Stock';
            errorMessage =
                '${outOfStockProduct.product.productName} is out of stock. Please remove it from your cart.';
          }
          // Check for validation errors
          else if (responseBody.contains('validation') ||
              responseBody.contains('required')) {
            errorTitle = 'Validation Error';
            errorMessage = 'Please check all information and try again.';
          }
          // Try to parse JSON error
          else {
            final errorData = jsonDecode(responseBody);
            errorMessage =
                errorData['message'] ?? errorData['error'] ?? errorMessage;
          }
        } catch (e) {
          // If response is HTML error page
          if (response.body.contains('Not enough stock')) {
            errorTitle = 'Out of Stock';
            errorMessage =
                'Some items in your cart are out of stock. Please remove them and try again.';
          }
        }

        // Show error dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 8),
                Text(errorTitle),
              ],
            ),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Optionally navigate to cart page
                  if (errorMessage.contains('out of stock')) {
                    Navigator.pop(context); // Go back to cart
                  }
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isProcessing = false;
      });
      print("Order Error: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Network Error: Please check your connection'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

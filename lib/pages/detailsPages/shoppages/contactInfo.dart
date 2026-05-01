import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nyxproject/pages/detailsPages/shoppages/payment.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';

class contactInfo extends StatefulWidget {
  const contactInfo({super.key});

  @override
  State<contactInfo> createState() => _contactInfoState();
}

class _contactInfoState extends State<contactInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sessionService = Provider.of<SessionService>(context);
    
    // If not logged in, show redirect message
    if (!sessionService.isLoggedIn()) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 64, color: Colors.grey),
              const SizedBox(height: 20),
              const Text(
                "Please login to continue",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        sessionService: sessionService,
                        cartService: Provider.of<CartService>(context, listen: false),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Go to Login"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 20),
              _section("Contact Information"),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField(
                      label: "Full Name",
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      hintText: "Enter your full name",
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Phone Number",
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      hintText: "09 xxx xxx xxx",
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Email Address",
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "example@gmail.com",
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Delivery Address",
                      controller: addressController,
                      keyboardType: TextInputType.streetAddress,
                      hintText: "Enter your address",
                      isRequired: true,
                    ),
                    const SizedBox(height: 10),
                    _buildTextField(
                      label: "Remark",
                      controller: remarkController,
                      keyboardType: TextInputType.text,
                      hintText: "Any special instructions?",
                      isRequired: false,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              _continue(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required String hintText,
    required bool isRequired,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with required indicator
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: const TextStyle(
                    fontFamily: 'Custom',
                    color: Color.fromARGB(255, 13, 27, 42),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                if (isRequired)
                  const TextSpan(
                    text: " *",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          // Text Field
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: const TextStyle(
              fontFamily: "Custom",
              color: Colors.white,
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: 'Custom',
                color: Colors.grey,
                fontSize: 13,
              ),
              filled: true,
              fillColor: const Color.fromARGB(255, 13, 27, 42),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.red),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            validator: (value) {
              if (isRequired) {
                if (value == null || value.isEmpty) {
                  return "$label is required";
                }
              }
              if (label == "Email Address" && value != null && value.isNotEmpty) {
                if (!value.contains('@') || !value.contains('.')) {
                  return "Enter a valid email address";
                }
              }
              if (label == "Phone Number" && value != null && value.isNotEmpty) {
                if (value.length < 9 || value.length > 11) {
                  return "Enter a valid phone number";
                }
              }
              return null;
            },
          ),
        ],
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          ),
          const Expanded(
            child: Text(
              "Information",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: Color.fromARGB(255, 13, 27, 42),
            fontWeight: FontWeight.w900,
            fontFamily: 'Custom',
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget _continue() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _validateAndContinue,
        label: const Text(
          "Continue",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 15,
          ),
        ),
        icon: const Icon(Icons.arrow_right_alt_sharp, color: Colors.white),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  void _validateAndContinue() {
    final sessionService = Provider.of<SessionService>(context, listen: false);
    
    if (!sessionService.isLoggedIn()) {
      _showLoginRequiredDialog();
      return;
    }

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final cartService = Provider.of<CartService>(context, listen: false);
    final totalAmount = cartService.totalPrice;

    Map<String, String> contactInfo = {
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'address': addressController.text.trim(),
      'remark': remarkController.text.trim(),
    };

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Payment(
          totalAmount: totalAmount,
          contactInfo: contactInfo,
        ),
      ),
    );
  }

  void _showLoginRequiredDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("Login Required"),
        content: const Text("Please login to continue with your order."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(
                    sessionService: Provider.of<SessionService>(context, listen: false),
                    cartService: Provider.of<CartService>(context, listen: false),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text("Login Now"),
          ),
        ],
      ),
    );
  }
}
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
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() {
    final sessionService = Provider.of<SessionService>(context, listen: false);
    
    if (!sessionService.isLoggedIn()) {
      // Show dialog and redirect to login
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showLoginRequiredDialog();
      });
    }
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
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to previous page
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.push(
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
    
    // If not logged in, show loading or redirect message
    if (!sessionService.isLoggedIn()) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              const Text("Checking login status..."),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
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
                    _section1("Full Name *"),
                    const SizedBox(height: 5),
                    _input(nameController, "Enter your full name", TextInputType.name),
                    const SizedBox(height: 15),
                    _section1("Phone Number *"),
                    const SizedBox(height: 5),
                    _input(phoneController, "09 xxx xxx xxx", TextInputType.phone),
                    const SizedBox(height: 15),
                    _section1("Email Address *"),
                    const SizedBox(height: 5),
                    _input(emailController, "example@gmail.com", TextInputType.emailAddress),
                    const SizedBox(height: 15),
                    _section1("Delivery Address *"),
                    const SizedBox(height: 5),
                    _input(addressController, "Enter your address", TextInputType.streetAddress),
                    const SizedBox(height: 15),
                    _section1("Remark (Optional)"),
                    const SizedBox(height: 5),
                    _input(remarkController, "Any special instructions?", TextInputType.text),
                    const SizedBox(height: 15),
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

  Widget _header() {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
            ),
          ),
          const Expanded(
            child: Text(
              "Information",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Text(title,
         style: const TextStyle(
          color: Color.fromARGB(255, 13, 27, 42), 
          fontWeight: FontWeight.w900,
          fontFamily: 'Custom',
          fontSize: 22
          )
        ),
      ),
    );
  }

  Widget _section1(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42), 
        fontWeight: FontWeight.w600,
        fontFamily: 'Custom',
        fontSize: 15,
        )
      ),
    );
  }

  Widget _input(TextEditingController controller, String hintText, TextInputType keyboardType) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: "Custom",
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          filled: true,
          fillColor: const Color.fromARGB(255, 13, 27, 42),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          ),
        ),
        validator: (value) {
          if (controller == nameController || 
              controller == phoneController || 
              controller == emailController || 
              controller == addressController) {
            if (value == null || value.isEmpty) {
              return "This field is required";
            }
          }
          if (controller == emailController && value != null && value.isNotEmpty) {
            if (!value.contains('@') || !value.contains('.')) {
              return "Enter a valid email address";
            }
          }
          if (controller == phoneController && value != null && value.isNotEmpty) {
            if (value.length < 9 || value.length > 11) {
              return "Enter a valid phone number";
            }
          }
          return null;
        },
      ),
    );
  }

  Widget _continue(){
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
    // Double check login before proceeding
    final sessionService = Provider.of<SessionService>(context, listen: false);
    
    if (!sessionService.isLoggedIn()) {
      _showLoginRequiredDialog();
      return;
    }

    // Validate form
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Collect contact information
    Map<String, String> contactInfo = {
      'name': nameController.text.trim(),
      'phone': phoneController.text.trim(),
      'email': emailController.text.trim(),
      'address': addressController.text.trim(),
      'remark': remarkController.text.trim(),
    };

    // Get cart service for total amount
    final cartService = Provider.of<CartService>(context, listen: false);
    final totalAmount = cartService.totalPrice;

    // Navigate to Payment page with contact info
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
}
import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/OTP.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/terms.dart';
import 'package:nyxproject/services/cart_service.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/util/Api.dart';

class SignupPage extends StatefulWidget {
  final SessionService sessionService;
   final CartService? cartService;
  const SignupPage({super.key, required this.sessionService, this.cartService});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final formKey = GlobalKey<FormState>();
  bool _isChecked = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController =
      TextEditingController(); // ADDED
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dobController = TextEditingController();

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        // dobController.text = "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
        dobController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose(); // ADDED
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              const SizedBox(height: 10),
              _userInput(),
              const SizedBox(height: 20),
              _footer(),
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
              "Create User",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            TextFormField(
              controller: nameController,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Name*",
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Email Field
            TextFormField(
              controller: emailController,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Email*",
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter email";
                }
                if (!value.contains('@')) {
                  return "Enter a valid email";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Phone Field - ADDED
            TextFormField(
              controller: phoneController,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Phone Number* (11 digits)",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: const Icon(Icons.phone, color: Colors.white70),
              ),
              keyboardType: TextInputType.phone,
              maxLength: 11,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter phone number";
                }
                if (value.length != 11) {
                  return "Phone number must be exactly 11 digits";
                }
                if (!RegExp(r'^[0-9]{11}$').hasMatch(value)) {
                  return "Phone number must contain only numbers";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Date of Birth Field
            TextFormField(
              controller: dobController,
              readOnly: true,
              onTap: _selectDate,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Date of Birth*",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(
                  Icons.calendar_today,
                  color: Colors.white,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please select your date of birth";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Password Field
            TextFormField(
              controller: passwordController,
              obscureText: true,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Password*",
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter password";
                }
                if (value.length < 6) {
                  return "Password must be at least 6 characters";
                }
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Confirm Password Field
            TextFormField(
              controller: confirmPasswordController,
              obscureText: true,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Confirm Password*",
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Confirm password";
                }
                if (value != passwordController.text) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),

            const SizedBox(height: 35),

            // SIGN UP BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(350, 50),
                  backgroundColor: Colors.red,
                ),
                onPressed: _handleSignUp,
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Login Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: 15,
                    color: Color.fromARGB(255, 13, 27, 42),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LoginPage(sessionService: widget.sessionService),
                      ),
                    );
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: "Custom",
                      fontSize: 15,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Separate signup handler method
  Future<void> _handleSignUp() async {
    // Check if form is valid
    if (!formKey.currentState!.validate()) return;

    // Check if terms are accepted
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please agree to the Terms & Conditions")),
      );
      return;
    }

    // Check password match
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    // Parse date of birth to YYYY-MM-DD format for API
    String formattedDate = _parseDateForApi(dobController.text.trim());

    try {
      final Map<String, dynamic> signupResult = await Api.signupUser(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim(), // Make sure you have this field
        dateOfBirth: formattedDate,
        password: passwordController.text.trim(),
      );

      if (!mounted) return;

      // Check success using the 'success' field from our fixed API
      final bool success = signupResult['success'] == true;

      if (success) {
        final String email = emailController.text.trim();
        // Get tempToken from the response
        final String tempToken = signupResult['tempToken']?.toString() ?? '';

        print("TempToken received: $tempToken"); // Debug print

        if (tempToken.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Missing verification token from server"),
            ),
          );
          return;
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("OTP sent successfully!"),
              backgroundColor: Colors.green,
            ),
          );
        }
        // Navigate to OTP page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTP(
              email: email,
              tempToken: tempToken,
              sessionService: widget.sessionService,
              cartService: widget.cartService,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              signupResult['message']?.toString() ?? "Signup failed",
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  // Helper method to parse date from DD/MM/YYYY to YYYY-MM-DD
  String _parseDateForApi(String date) {
    try {
      final parts = date.split('/');
      if (parts.length == 3) {
        final day = parts[0].padLeft(2, '0');
        final month = parts[1].padLeft(2, '0');
        return "${parts[2]}-$month-$day";
      }
      return date;
    } catch (e) {
      return date;
    }
  }

  Widget _footer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CheckboxListTile(
          title: const Text("By registration, I have read and agree to the"),
          value: _isChecked,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          controlAffinity: ListTileControlAffinity.leading,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const termsPage()),
                );
              },
              child: const Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
            const Text(" and "),
            TextButton(
              onPressed: () {
                // Navigate to Privacy Policy
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
                // );
              },
              child: const Text(
                "Privacy Policy",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:nyxproject/models/User.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/signup.dart';
// import 'package:nyxproject/pages/detailsPages/accountpages/signup.dart';
import 'package:nyxproject/pages/detailsPages/dashboard.dart';
import 'package:nyxproject/pages/main_dashboard.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/util/Api.dart';
import 'package:nyxproject/services/cart_service.dart';
// import 'package:nyxproject/pages/main_dashboard.dart';
// import '../../../db_helper.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'lib/pages/detailsPages/accountpages/signup.dart';
// import 'home.dart';

// Future<bool> loginUser(String email, String password) async {
//   final url = Uri.parse(""); // emulator fix - API Here

//   final response = await http.post(
//     url,
//     headers: {"Content-Type": "application/json"},
//     body: jsonEncode({
//       "email": email,
//       "password": password,
//     }),
//   );

//   final data = jsonDecode(response.body);
//   return data["success"];
// }

class LoginPage extends StatefulWidget {
  final SessionService sessionService;
  final CartService? cartService;
  const LoginPage({super.key, required this.sessionService, this.cartService});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double get screenWidth => MediaQuery.of(context).size.width;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // DBHelper dbHelper = DBHelper();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
              SizedBox(height: 10),
              _MainIcon(),
              Divider(),
              _inputform(),
              SizedBox(height: 10),

              _login(),
              SizedBox(height: 10),
              _toSignUp(),
              SizedBox(height: 10),
              _continuewith("--- or Continue With ---"),
              SizedBox(height: 15),
              _choice(),
              SizedBox(height: 15),
              _toSignUp(),
              Divider(),
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
              // Navigate back to MainDashboard
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MainDashboard(
                    sessionService: widget.sessionService,
                    cartService: widget.cartService, //  Remove the ! (nullable)
                  ),
                ),
                (route) => false,
              );
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          const Expanded(
            child: Text(
              "Login",
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

  bool _isPasswordVisible = false;

  Widget _inputform() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Email Field
            TextFormField(
              controller: emailController,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Email",
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
                return null;
              },
            ),

            const SizedBox(height: 10),

            // Password Field with Visibility Toggle
            TextFormField(
              controller: passwordController,
              obscureText: !_isPasswordVisible,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: const Color.fromARGB(255, 13, 27, 42),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
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
          ],
        ),
      ),
    );
  }

  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 13, 27, 42)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 13, 27, 42),
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 13, 27, 42),
          width: 2,
        ),
      ),
    );
  }

  Widget _forget() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forget password?",
          style: TextStyle(
            fontFamily: "Custom",
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _login() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 50),
          backgroundColor: Colors.red,
        ),
        onPressed: () async {
          if (!_formKey.currentState!.validate()) return;

          final email = emailController.text.trim();
          final password = passwordController.text;

          final Map<String, dynamic> loginResult = await Api.loginUser(
            emailOrphone: email,
            password: password,
          );
          final bool success = loginResult['success'] == true;

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                success
                    ? "Login success"
                    : (loginResult['message']?.toString() ?? "Invalid login"),
              ),
            ),
          );

          if (success) {
            final dynamic rawData = loginResult['data'];
            Map<String, dynamic> responseMap = <String, dynamic>{};
            if (rawData is Map<String, dynamic>) {
              responseMap = rawData;
            }

            // Get token first
            final String token = responseMap['token']?.toString() ?? '';

            //  Fetch full user profile using the token
            final profileResult = await Api.getMyProfile(token: token);

            User user;

            if (profileResult['success'] == true) {
              // Use profile data which should have full user info
              final userData = profileResult['data'] as Map<String, dynamic>;
              print(" Profile data: $userData");

              user = User(
                id: userData['id'] != null
                    ? int.tryParse(userData['id'].toString())
                    : null,
                name: userData['name']?.toString(),
                email: userData['email']?.toString() ?? email,
                phone: userData['phone']?.toString(),
                imageUrl: userData['image_url']?.toString(),
                dateOfBirth: userData['dateOfBirth']?.toString(),
                address: userData['address']?.toString(),
              );
            } else {
              // Fallback to login response data
              final dynamic rawUser = responseMap['user'];
              Map<String, dynamic> userJson = {};

              if (rawUser is Map<String, dynamic>) {
                userJson = rawUser;
              } else {
                userJson = responseMap;
              }

              print(" Login response user data: $userJson");

              user = User(
                id: userJson['id'] != null
                    ? int.tryParse(userJson['id'].toString())
                    : null,
                name: userJson['name']?.toString(),
                email: userJson['email']?.toString() ?? email,
                phone: userJson['phone']?.toString(),
                imageUrl: userJson['image_url']?.toString(),
                dateOfBirth: userJson['dateOfBirth']?.toString(),
                address: userJson['address']?.toString(),
              );
            }

            print(
              " User to save - ID: ${user.id}, Name: ${user.name}, Email: ${user.email}",
            );

            await widget.sessionService.saveSession(user, token);

            // Verify save
            final savedUser = widget.sessionService.getStoredUser();
            print(
              " Verified saved user - ID: ${savedUser?.id}, Name: ${savedUser?.name}",
            );

            if (!mounted) return;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MainDashboard(
                  sessionService: widget.sessionService,
                  cartService: widget.cartService,
                ),
              ),
            );
          }
        },
        child: Text(
          "LOGIN",
          style: TextStyle(
            fontFamily: "Custom",
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _continuewith(String title) {
    return Center(
      child: Text(title, style: TextStyle(fontFamily: "Custom", fontSize: 15)),
    );
  }

  Widget _choice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.facebook_rounded),
            label: Text(
              "Facebook",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 13, 27, 42),
              iconColor: Colors.white,
            ),
          ),
        ),
        SizedBox(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: FaIcon(FontAwesomeIcons.google),
            label: Text(
              "Google",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 13, 27, 42),
              iconColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _MainIcon() {
    return Center(child: FaIcon(FontAwesomeIcons.user, size: 200));
  }

  Widget _toSignUp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account",
          style: TextStyle(fontFamily: "Custom", fontSize: 15),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignupPage(
                  sessionService: widget.sessionService,
                  cartService: widget.cartService,
                ),
              ),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 15,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _toSignUp(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account",
          style: TextStyle(
            fontFamily: "Custom",
            fontSize: 15,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                SignupPage(),
              )
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 15,
              color: Colors.red
            ),
          ),
        ),
      ],
    );
  }
}

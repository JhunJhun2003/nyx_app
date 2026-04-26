import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/aboutus.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/contactus.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/editprofile.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/help.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/login.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/myclasses.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/myorder.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/mywishlist.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/setting.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/signup.dart';
import 'package:nyxproject/pages/detailsPages/accountpages/terms.dart';
import 'package:nyxproject/pages/main_dashboard.dart';
import 'package:nyxproject/services/session_service.dart';
import 'package:nyxproject/services/cart_service.dart';

class AccountPage extends StatefulWidget {
  final SessionService sessionService;
  final CartService? cartService;
  
  const AccountPage({
    super.key, 
    required this.sessionService,
    this.cartService,
  });

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final isLoggedIn = widget.sessionService.isLoggedIn();
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              
              // Show login/signup section only when NOT logged in
              if (!isLoggedIn) ...[
                _accountTab(context),
                const Divider(),
              ],
              
              _section("Account"),
              
              // ✅ Edit Profile - Only show when logged in
              if (isLoggedIn) ...[
                _menuItem(Icons.edit, "Edit Profile", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(sessionService: widget.sessionService),
                    ),
                  );
                }),
              ],
              
              _menuItem(Icons.shopping_cart_outlined, "My Orders", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => myOrder()),
                );
              }),
              
              _menuItem(Icons.favorite, "My Wishlist", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => mywishlist()),
                );
              }),
              
              _menuItem(Icons.list_alt, "My Classes", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Classes()),
                );
              }),
              
              const Divider(),
              _section("Settings"),
              
              _menuItem(Icons.settings, "Setting & Preferences", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Setting()),
                );
              }),
              
              const Divider(),
              _section("Others"),
              
              _menuItem(Icons.info_outline, "About Us", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => aboutUs()),
                );
              }),
              
              _menuItem(Icons.phone, "Contact Us", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              }),
              
              _menuItem(Icons.help_outline, "Help Center", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => helpPage()),
                );
              }),
              
              _menuItem(Icons.policy, "Terms & Policies", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => termsPage()),
                );
              }),
              
              const Divider(),
              const SizedBox(height: 10),
              
              // Show logout button only when logged in
              if (isLoggedIn) _logout(),
              
              const SizedBox(height: 10),
            ],
          ),
        ),
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
          fontSize: 18,
          fontFamily: 'Custom',
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _accountTab(BuildContext context) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Login to your account.",
              style: const TextStyle(
                fontFamily: "Custom",
                fontSize: 15,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        sessionService: widget.sessionService,
                        cartService: widget.cartService,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                "or",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(100, 40),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupPage(
                        sessionService: widget.sessionService,
                        cartService: widget.cartService,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 Reusable Menu Item
  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: const Color(0xFF0D1B2A)),
          title: Text(title, style: const TextStyle(fontFamily: 'Custom')),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _logout() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: () async {
          await widget.sessionService.logout();
          if (!mounted) return;
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => MainDashboard(
                sessionService: widget.sessionService,
                cartService: widget.cartService,
              ),
            ),
            (route) => false,
          );
        },
        icon: const Icon(Icons.logout),
        label: const Text(
          "Logout",
          style: TextStyle(color: Colors.white, fontFamily: 'Custom'),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          iconColor: Colors.white,
        ),
      ),
    );
  }
}
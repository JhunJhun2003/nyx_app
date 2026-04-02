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
import 'package:nyxproject/pages/detailsPages/accountpages/terms.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _header(),
                SizedBox(height: 5),
                _accountTab(context),
                Divider(),
                _section("Account"),
                _menuItem(
                  Icons.edit,
                  "Edit Profile",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => editProfile()),
                    );
                  },
                ),
                _menuItem(
                  Icons.shopping_cart_outlined, 
                  "My Orders",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => myOrder()),
                    );
                  },
                ),
                _menuItem(
                  Icons.favorite, 
                  "My Wishlist",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mywishlist()),
                    );
                  },
                ),
                _menuItem(
                  Icons.list_alt, 
                  "My Classes",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Classes()),
                    );
                  },
                ),
                Divider(),
                _section("Settings"),
                _menuItem(
                  Icons.settings, 
                  "Setting & Preferences",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                ),
                Divider(),
                _section("Others"),
                _menuItem(
                  Icons.info_outline, 
                  "About Us",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => aboutUs()),
                    );
                  },
                ),
                _menuItem(
                  Icons.phone, 
                  "Contact Us",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ContactUs()),
                    );
                  },
                ),
                _menuItem(
                  Icons.help_outline, 
                  "Help Center",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => helpPage()),
                    );
                  },
                ),
                _menuItem(
                  Icons.policy, 
                  "Terms & Policies",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => termsPage()),
                    );
                  },
                ),
                Divider(),
                const SizedBox(height: 10),

                _logout(),

                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
    );
  }

  Widget _header() {
  return Container(
    color: const Color.fromARGB(255, 13, 27, 42),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
            height: 30,
            child: Image.asset(
              'assets/images/logo1.png',
              fit: BoxFit.contain,
            ),
          ),
          const Row(
            children: [
              Icon(Icons.language, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.notifications_none, color: Colors.white),
              SizedBox(width: 10),
              Icon(Icons.shopping_cart_outlined, color: Colors.white),
            ],
          )
        ],
      ),
    );
  }

  Widget _section(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42),
        fontSize: 18,
        fontFamily: 'Custom',
        fontWeight: FontWeight.w900,
        )
      ),
    );
  }

  Widget _accountTab(BuildContext context){
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("Login to your account.",style: TextStyle(fontFamily: "Custom", fontSize: 15, color: Colors.white),),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                }, 
                child: Text("Login",style: TextStyle(fontFamily: "Custom", fontSize: 15, color: Colors.white),),
              ),
              Text("or",style: TextStyle(fontFamily: "Custom", fontSize: 15, color: Colors.white),),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: (){}, 
                child: Text("Sign Up",style: TextStyle(fontFamily: "Custom", fontSize: 15, color: Colors.white),),
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
          title: Text(title, style: TextStyle(fontFamily: 'Custom',),),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
          onTap: onTap,
        ),
      ),
    );
  }

  Widget _logout(){
    return Center(
      // padding: EdgeInsetsDirectional.symmetric(),
      child: ElevatedButton.icon(
        onPressed: (){}, 
        icon: Icon(Icons.logout),
        label: Text("Logout", style: TextStyle(color: Colors.white,fontFamily: 'Custom'),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          iconColor: Colors.white
        ),
      ),
    );
  }
//   // 🔹 Logout Button
//   Widget _logoutButton() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 40),
//       child: ElevatedButton.icon(
//         onPressed: () {},
//         icon: const Icon(Icons.logout),
//         label: const Text("Log Out"),
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xFF0D1B2A),
//           padding: const EdgeInsets.symmetric(vertical: 14),
//         ),
//       ),
//     );
//   }
}


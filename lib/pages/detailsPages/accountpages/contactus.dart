import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  double get screenWidth => MediaQuery.of(context).size.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( 
      //   title: 
      //     Text("Help Center"),
      //     titleTextStyle: 
      //       TextStyle(
      //         fontSize: 20,
      //         fontFamily: 'Custom',
      //         color: const Color(0xFF0D1B2A),
      //         fontWeight: FontWeight.w700
      //       ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              SizedBox(height: 10),
              _menuItem(
                  Icons.mail,
                  "Shopping@nyx.com",() {},
                ),
              _menuItem(
                  Icons.language,
                  "https://shop.nyx.com/contact.html",() {},
                ),
              _menuItem(
                  Icons.facebook,
                  "https://www.facebook.com/nyxstore",() {},
                ),
              _menuItem(
                  Icons.call_sharp,
                  "09 xxx xxx xxx",() {},
                ),
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
          icon: Icon(
            Icons.arrow_back_ios_new_rounded, 
            color: Colors.white,
            ),
          ),
          Expanded(
            child: const Text(
              "Setting", 
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

  Widget _menuItem(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 13, 27, 42),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          title: Text(title, style: TextStyle(fontFamily: 'Custom',color: Colors.white),),
        ),
      ),
    );
  }
}
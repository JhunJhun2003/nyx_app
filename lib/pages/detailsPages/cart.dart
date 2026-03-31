import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

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
}
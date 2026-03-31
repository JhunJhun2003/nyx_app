import 'package:flutter/material.dart';

class mywishlist extends StatefulWidget {
  const mywishlist({super.key});

  @override
  State<mywishlist> createState() => _mywishlistState();
}

class _mywishlistState extends State<mywishlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text("My Wishlist"),),
      body: Center(
        child: Text("My Wishlist Page"),
      ),
    );
  }
}
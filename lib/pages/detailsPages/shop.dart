import 'package:flutter/material.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // _header(),
                _searchBar(),
              ],
            ),
          ),
        ),
    );
  }

  // Widget _header() {
  // return Container(
  //   color: const Color.fromARGB(255, 13, 27, 42),
  //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       SizedBox(
  //           height: 30,
  //           child: Image.asset(
  //             'assets/images/logo1.png',
  //             fit: BoxFit.contain,
  //           ),
  //         ),
  //         Row(
  //           children: [
  //             IconButton(onPressed: (){}, icon: Icon(Icons.language, color: Colors.white,)),
  //             IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none, color: Colors.white,)),
  //             IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined, color: Colors.white,)),
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: "What are you looking for ?",
          hintStyle: TextStyle(
            fontFamily: 'Custom',
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 13, 27, 42),
          suffixIcon: const Icon(Icons.search),
          suffixIconColor: Colors.white,
          // suffixIcon: const Icon(Icons.tune),
          // suffixIconColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
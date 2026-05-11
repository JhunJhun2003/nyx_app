import 'package:flutter/material.dart';

class Courts extends StatefulWidget {
  const Courts({super.key});

  @override
  State<Courts> createState() => _CourtsState();
}

class _CourtsState extends State<Courts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
            ],
          ),
        )
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
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Courts",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
        ],
      ),
    );
  }
}
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
              SizedBox(height: 10),
              _courtHeader(),
              SizedBox(height: 10),
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

  Widget _courtHeader(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Court",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 3),
          Text(
            "Choose you court to play comfortablly.",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }


}
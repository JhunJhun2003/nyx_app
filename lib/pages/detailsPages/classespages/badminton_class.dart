import 'package:flutter/material.dart';

class BadmintonClass extends StatefulWidget {
  const BadmintonClass({super.key});

  @override
  State<BadmintonClass> createState() => _BadmintonClassState();
}

class _BadmintonClassState extends State<BadmintonClass> {
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
              _imageSpace(),
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
            child: Text(
              "Badminton Pro Training Center",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          IconButton(
            onPressed: (){}, 
            icon: Icon(
              Icons.bookmark, 
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imageSpace(){
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: BoxBorder.all(color: Colors.black, width: 2),
        ),
        child: 
          Image(
            image: AssetImage("assets/classes/Badminton.png"),
            fit: BoxFit.fill
          ),
      ),
    );
  }

}
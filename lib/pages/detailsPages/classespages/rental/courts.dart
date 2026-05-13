import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/badminton_rantal.dart';

class Courts extends StatefulWidget {
  const Courts({super.key});

  @override
  State<Courts> createState() => _CourtsState();
}

class _CourtsState extends State<Courts> {
  double get screenWidth => MediaQuery.of(context).size.width;
  double get screenHeight => MediaQuery.of(context).size.height;

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
              _court1(
                context,
                "Badminton Courts",
                "assets/images/badminton_court.jpg",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: 5),
              _court1(
                context,
                "Badminton Courts",
                "assets/images/badminton_court.jpg",
                screenWidth,
                screenHeight,
              ),
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

  Widget _court1(
    BuildContext context,
    String title,
    String imagePath,
    double screenWidth,
    double screenHeight,
  ){
    return Container(
      height: screenHeight * 0.35,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: screenHeight * 0.3,
                width: screenWidth,
              ),
            ),
          ),
          Positioned(
            left: screenWidth * 0.025,
            bottom: screenHeight * 0.05,
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontFamily: "Custom",
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            right: screenWidth * 0.025,
            bottom: screenHeight * 0.05,
            child: Text(
              "25,000 Ks",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontFamily: "Custom",
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            left: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Courts(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                width: screenWidth * 0.48,
                height: screenHeight * 0.04,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => badmintonRantalState(),
                      ),
                    );
                  },
                  child: Text(
                    "Booking",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: "Custom",
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Courts(),
                  ),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                width: screenWidth * 0.48,
                height: screenHeight * 0.04,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: GestureDetector(
                  onTap: (){

                  },
                  child: Text(
                    "Court Details",
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontFamily: "Custom",
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
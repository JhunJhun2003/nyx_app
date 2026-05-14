import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/badminton_rantal.dart';

class Courts extends StatefulWidget {
  const Courts({super.key});

  @override
  State<Courts> createState() => _CourtsState();
}

class _CourtsState extends State<Courts> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _courtHeader(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.015),
              _courtCard(
                context,
                "Badminton Court 1",
                "assets/images/badminton_court.jpg",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.015),
              _courtCard(
                context,
                "Badminton Court 2",
                "assets/images/badminton_court.jpg",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.015),
              _courtCard(
                context,
                "Badminton Court 3",
                "assets/images/badminton_court.jpg",
                screenWidth,
                screenHeight,
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(double screenWidth, double screenHeight) {
    return Container(
      color: const Color.fromARGB(255, 13, 27, 42),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02, 
        vertical: screenHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: Icon(
              Icons.arrow_back_ios_new_rounded, 
              color: Colors.white,
              size: screenWidth * 0.055,
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          Expanded(
            child: Text(
              "Courts",
              style: TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _courtHeader(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Choose Court",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: screenWidth * 0.055,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            "Choose your court to play comfortably.",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: screenWidth * 0.04,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _courtCard(
    BuildContext context,
    String title,
    String imagePath,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      height: screenHeight * 0.32,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.025),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Stack(
        children: [
          // Background Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                height: screenHeight * 0.2,
                width: screenWidth,
              ),
            ),
          ),
          // Title
          Positioned(
            left: screenWidth * 0.04,
            bottom: screenHeight * 0.08,
            child: Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontFamily: "Custom",
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Price
          Positioned(
            right: screenWidth * 0.04,
            bottom: screenHeight * 0.08,
            child: Text(
              "25,000 Ks",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontFamily: "Custom",
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Booking Button (Left)
          Positioned(
            bottom: screenHeight * 0.015,
            left: screenWidth * 0.025,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => badmintonRantalState(),
                  ),
                );
              },
              child: Container(
                width: (screenWidth - screenWidth * 0.07) / 2.2,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "Booking",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontFamily: "Custom",
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Court Details Button (Right)
          Positioned(
            bottom: screenHeight * 0.015,
            right: screenWidth * 0.025,
            child: GestureDetector(
              onTap: () {
                // Navigate to court details page
                // TODO: Implement court details
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Court Details for $title"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Container(
                width: (screenWidth - screenWidth * 0.07) / 2.2,
                height: screenHeight * 0.045,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    "Court Details",
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      fontFamily: "Custom",
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
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
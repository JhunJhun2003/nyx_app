// lib/pages/detailsPages/classesWidgets/rentals_widget.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/courts.dart';

class RentalsWidget extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const RentalsWidget({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Court Rentals",
              style: TextStyle(
                fontSize: 19,
                fontFamily: "Custom",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Book your own private court.",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Custom",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10),
          _buildCourtCard(
            context,
            "Badminton Courts",
            "assets/images/badminton_court.jpg",
            screenWidth,
            screenHeight,
          ),
          const SizedBox(height: 10),
          _buildCourtCard(
            context,
            "Tennis Courts",
            "assets/images/tennis_court.jpg",
            screenWidth,
            screenHeight,
          ),
          const SizedBox(height: 10),
          _buildCourtCard(
            context,
            "Futsal Courts",
            "assets/images/futsal_court.jpg",
            screenWidth,
            screenHeight,
          ),
          const SizedBox(height: 10),
        ],
        key: const ValueKey("rentals"),
      ),
    );
  }

  Widget _buildCourtCard(
    BuildContext context,
    String title,
    String imagePath,
    double screenWidth,
    double screenHeight,
  ) {
    return Container(
      height: screenHeight * 0.4,
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
            bottom: screenHeight * 0.07,
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
            bottom: screenHeight * 0.07,
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
            bottom: screenHeight * 0.01,
            left: 0,
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
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "See Details",
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
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/badminton_class.dart';
import 'package:nyxproject/pages/detailsPages/classespages/badminton_rantal.dart';
import 'package:nyxproject/pages/detailsPages/classespages/contactInfo_snack.dart';
import 'package:nyxproject/pages/detailsPages/classespages/futsal_class.dart';
import 'package:nyxproject/pages/detailsPages/classespages/tennis_class.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  int selectedIndex = 0;

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
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTab("TRAININGS", 0),
                  _buildTab("RENTALS", 1),
                  _buildTab("CANTEEN", 2),
                ],
              ),
              SizedBox(height: 15),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: selectedIndex == 0
                    ? _trainings()
                    : selectedIndex == 1
                    ? _rentals(screenWidth, screenHeight)
                    : _canteen( screenWidth, screenHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 13, 27, 42)
              : Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontFamily: "Custom",
            ),
          ),
        ),
      ),
    );
  }

  Widget _trainings() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contex) => BadmintonClass()),
              );
            },
            child: Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(7, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage("assets/classes/Badminton.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contex) => futsalClass()),
              );
            },
            child: Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(7, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage("assets/classes/Futsal.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (contex) => tennisClass()),
              );
            },
            child: Container(
              height: 180,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(7, 5),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage("assets/classes/Tennis.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ],
        key: ValueKey("training"),
      ),
    );
  }

  Widget _rentals(double screenWidth, double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Court Rentals",
              style: TextStyle(
                fontSize: 19,
                fontFamily: "Custom",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 3),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "Book your own private court.",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Custom",
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 10),
          _badmintonCourt(screenWidth, screenHeight),
          SizedBox(height: 10),
          _tennisCourt(screenWidth, screenHeight),
          SizedBox(height: 10),
          _futsals(screenWidth, screenHeight),
          SizedBox(height: 10),
        ],
        key: ValueKey("rentals"),
      ),
    );
  }

  Widget _badmintonCourt(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.45, // Responsive height
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
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
                "assets/images/badminton_court.jpg",
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
              "Badminton Courts",
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
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (contex) => badmintonRantalState(),
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

  Widget _tennisCourt(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.45,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
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
                "assets/images/tennis_court.jpg",
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
              "Tennis Courts",
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
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (contex) => badmintonRantalState(),
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

  Widget _futsals(double screenWidth, double screenHeight) {
    return Container(
      height: screenHeight * 0.45,
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0125),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
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
                "assets/images/futsal_court.jpg",
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
              "Futsal Courts",
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
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (contex) => badmintonRantalState(),
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

  Widget _canteen(double screenWidth, double screenHeight) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_gridCards(screenWidth, screenHeight), SizedBox(height: 10)],
        key: ValueKey("canteen"),
      ),
    );
  }

  //for canteen products
  Widget _gridCards(double screenWidth, double screenHeight) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.001,
        vertical: screenHeight * 0.006,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 13, 27, 42),
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Column(
              children: [
                // Upper row - Image
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Icon(
                      Icons.image,
                      size: screenWidth * 0.45,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Lower section - Text information
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  child: Column(
                    children: [
                      // First row - Name and Price (side by side)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name",
                            style: TextStyle(
                              fontFamily: "Custom",
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Price(Ks)",
                            style: TextStyle(
                              fontFamily: "Custom",
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.005),

                      // Second row - Category (full width)
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

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
                        ? _rentals()
                        : _canteen(),
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
          color: isSelected ? Color.fromARGB(255, 13, 27, 42) : Colors.grey[300],
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
                MaterialPageRoute(
                  builder: (contex) => BadmintonClass(),
                ),
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
                  fit: BoxFit.fill
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (contex) => futsalClass(),
                ),
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
                MaterialPageRoute(
                  builder: (contex) => tennisClass(),
                ),
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
                  fit: BoxFit.fill
                ),
              ),
            ),
          ),
        ],
        key: ValueKey("training"),
      ),
    );
  }

  Widget _rentals() {
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
                color: Colors.black
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
                color: Colors.black
              ),
            ),
          ),
          SizedBox(height: 10),
          _badmintonCourt(),
          SizedBox(height: 10),
          _tennisCourt(),
          SizedBox(height: 10),
          _futsals(),
          SizedBox(height: 10),
        ],
        key: ValueKey("rentals"),
      ),
    );
  }

  Widget _badmintonCourt(){
    return Container(
      height: 350,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/badminton_court.jpg",
              fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: Text(
              "Badminton Courts",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
             right: 10,
             bottom: 50,
             child: Text(
              "25,000 Ks",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            bottom: 2,
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
                padding: EdgeInsets.symmetric(vertical: 8),
                width: 400,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "See Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Custom",
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _tennisCourt(){
    return Container(
      height: 350,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/tennis_court.jpg",
              fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: Text(
              "Tennis Courts",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
             right: 10,
             bottom: 50,
             child: Text(
              "25,000 Ks",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            bottom: 2,
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
                padding: EdgeInsets.symmetric(vertical: 8),
                width: 400,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "See Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Custom",
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _futsals(){
    return Container(
      height: 350,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(15)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset("assets/images/futsal_court.jpg",
              fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            child: Text(
              "Futsal Courts",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
             right: 10,
             bottom: 50,
             child: Text(
              "25,000 Ks",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Custom",
                color: Colors.white
              ),
            ),
          ),
          Positioned(
            bottom: 2,
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
                padding: EdgeInsets.symmetric(vertical: 8),
                width: 400,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "See Details",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Custom",
                      color: Colors.white
                    ),
                    textAlign: TextAlign.center,
                ),
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget _canteen() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gridCards(),
          SizedBox(height: 10),
          _comfirm(),
        ],
        key: ValueKey("canteen"),
      ),
    );
  }

  Widget _gridCards() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
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
              border: BoxBorder.all(color: Colors.black, width: 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  child: Icon(
                    Icons.image,
                    size: 180,
                    color: Colors.white,
                  )
                ),
                Positioned(
                  left: 10,
                  top: 170,
                  child: Text(
                    "Name",
                    style: const TextStyle(fontFamily: "Custom", fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 170,
                  child: Text(
                    "Price(Ks)",
                    style: const TextStyle(fontFamily: "Custom", fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 195,
                  child: Text(
                    "Catagory",
                    style: const TextStyle(fontFamily: "Custom", fontSize: 15, color: Colors.white),
                  ),
                ),
                Positioned(
                  left: 1,
                  bottom: 0,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red),
                      foregroundColor: WidgetStatePropertyAll(Colors.white),
                      fixedSize: WidgetStatePropertyAll(Size(189, 10)),
                    ),
                    onPressed: (){}, 
                    child: Text("Add to bill",style: const TextStyle(fontFamily: "Custom", fontSize: 15),)
                  )
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _comfirm(){
    return Container(
      height: 80,
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Stack(
        children: [
          Positioned(
            top: 5,
            left: 5,
            child: Text(
              "Total :",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 15,
              ),
            )
          ),
          Positioned(
            top: 5,
            right: 10,
            child: Text(
              "10,000 Ks",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 15,
              ),
            )
          ),
          Positioned(
            left: 120,
            bottom: 0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => contactInfoSnack()),
                );
              }, 
              child: Text(
                "Order Comfirm",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 15,
                ),
              )
            )
          ),
        ],
      ),
    );
  }

}
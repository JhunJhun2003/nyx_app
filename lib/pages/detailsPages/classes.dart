import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/badminton_class.dart';

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
          Container(
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
          Container(
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
        ],
        key: ValueKey("training"),
      ),
    );
  }

  Widget _rentals() {
    return Center(
      child: Text(
        "This is Rental.",
        key: ValueKey("rentals"),
      ),
    );
  }

  Widget _canteen() {
    return Center(
      child: Text(
        "This is Canteen.",
        key: ValueKey("canteen"),
      ),
    );
  }

}
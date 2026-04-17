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
              _section("Training Level"),
              SizedBox(height: 5),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    trainingCard(
                      icon: Icons.sports,
                      title: "Beginner",
                      description:
                          "Focus on proper grip, basic footwork, and foundational strokes for a solid start.",
                      isSelected: true,
                    ),
                    const SizedBox(width: 10),
                    trainingCard(
                      icon: Icons.flash_on,
                      title: "Intermediate",
                      description:
                          "Enhancing tactical awareness, physical stamina, and advanced court coverage.",
                    ),
                    const SizedBox(width: 10),
                    trainingCard(
                      icon: Icons.emoji_events,
                      title: "Advanced",
                      description:
                          "Intensive match simulation, elite drills, and tournament-ready mental preparation.",
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 5),
              _section("Training Schedules"),
              SizedBox(height: 5),
              _timeTable(),
              SizedBox(height: 5),
              _section("What You'll Learn"),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: _bottomBar(),
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

  Widget _section(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            width: 10
          ),
        ),
      ),
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(title,
       style: const TextStyle(
        color: Color.fromARGB(255, 13, 27, 42), 
        fontWeight: FontWeight.w600,
        fontFamily: 'Custom',
        )
      ),
    );
  }

  Widget trainingCard({
    required IconData icon,
    required String title,
    required String description,
    bool isSelected = false,
  }) {
    return Container(
      width: 160,
      height: 260, // 👈 VERY IMPORTANT
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 👈 replaces Spacer
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(icon, color: Colors.black, size: 28),
              ),

              const SizedBox(height: 12),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 135, 244, 139),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "50,000Ks/ month",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _timeTable() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.2),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.3),
          3: FlexColumnWidth(1.3),
        },
        children: [
          // Header Row
          TableRow(
            children: [
              _tableHeader("Time Slot"),
              _tableHeader("Weekdays(M-F)"),
              _tableHeader("Saturday"),
              _tableHeader("Sunday"),
            ],
          ),

          TableRow(
            children: [
              tableCell("8:00 - 10:00 AM"),
              tableCell("Private Session"),
              tableCell("Beginner Level"),
              tableCell("Intermediate"),
            ],
          ),

          TableRow(
            children: [
              tableCell("10:00 - 12:00 PM"),
              tableCell("Adults Training"),
              tableCell("Junior Elite"),
              tableCell("Advanced"),
            ],
          ),

          TableRow(
            children: [
              tableCell("4:00 - 6:00 PM"),
              tableCell("All Levels"),
              tableCell("Intermediate"),
              tableCell("Elite Squad"),
            ],
          ),

          TableRow(
            children: [
              tableCell("6:00 - 8:00 PM"),
              tableCell("Lady Only"),
              tableCell("Open Play"),
              tableCell("Match Analysis"),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  static Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
        ),
      ),
    );
  }
}
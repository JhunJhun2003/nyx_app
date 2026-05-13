import 'package:flutter/material.dart';

class futsalClass extends StatefulWidget {
  const futsalClass({super.key});

  @override
  State<futsalClass> createState() => _futsalClassState();
}

class _futsalClassState extends State<futsalClass> {
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
                            "Fundamental ball control, passing basics, and positioning",
                        isSelected: true,
                      ),
                      const SizedBox(width: 10),
                      trainingCard(
                        icon: Icons.flash_on,
                        title: "Intermediate",
                        description:
                            "Technical skills, individual brilliance, and team plays.",
                      ),
                      const SizedBox(width: 10),
                      trainingCard(
                        icon: Icons.emoji_events,
                        title: "Advanced",
                        description:
                            "Competitive tactics, fitness, and elite-level drills.",
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
                SizedBox(height: 5),
                _learning(),
                SizedBox(height: 5),
                _section("Meet Your Coach"),
                SizedBox(height: 5),
                _coach(),
                SizedBox(height: 5),
                _enroll(),
                SizedBox(height: 15),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _bottomBar(),
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
            image: AssetImage("assets/classes/Futsal.png"),
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
        fontSize: 16,
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
      height: 280, // 👈 VERY IMPORTANT
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
              "150,000Ks/ month",
              style: TextStyle(
                fontSize: 13,
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
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(1.5),
          1: FlexColumnWidth(1.5),
          2: FlexColumnWidth(1.5),
        },
        children: [
          // Header Row
          TableRow(
            children: [
              _tableHeader("Time Slot"),
              _tableHeader("Weekdays(M-F)"),
              _tableHeader("Weekend"),
            ],
          ),

          TableRow(
            children: [
              tableCell("8:00 - 10:00 AM"),
              tableCell("Private Session"),
              tableCell("Beginner Level"),
            ],
          ),

          TableRow(
            children: [
              tableCell("4:00 - 6:00 PM"),
              tableCell("General Skills"),
              tableCell("Advance Pro"),
            ],
          ),

          TableRow(
            children: [
              tableCell("6:00 - 8:00 PM"),
              tableCell("Lady Clubs"),
              tableCell("Open Match"),
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
  
  Widget _learning(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage("assets/classes/badminton_info.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                bulletText("Advanced Ball Control Techniques"),
                bulletText("Tactical Awareness & Vision"),
                bulletText("Professional Physical Conditioning"),
                bulletText("Match Analysis & Strategy"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _coach(){
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Coach U Kyaw",style: TextStyle(fontFamily: "Custom",fontSize: 15, fontWeight: FontWeight.w800, letterSpacing: 1),),
                Text("Former Pro Futsal Player",style: TextStyle(fontFamily: "Custom",fontSize: 15,fontWeight: FontWeight.w600),),
                const SizedBox(height: 20),
                Text('"Dedicated to grooming youth talent from basics to professional levels."',style: TextStyle(fontFamily: "Custom",fontSize: 13),)
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage("assets/classes/badminton_info.png"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 6,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontFamily: "Custom" ,fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _enroll(){
    return Container(
      margin: EdgeInsets.only(left: 260),
      child: ElevatedButton.icon(
        onPressed: (){}, 
        icon: Icon(Icons.event),
        label: Text("Enroll Now", style: TextStyle(color: Colors.white,fontFamily: 'Custom'),),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          iconColor: Colors.white
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      height: 170,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      color: Color.fromARGB(255, 13, 27, 42),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Ready to Master the Court?",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: const Color.fromARGB(255, 67, 251, 74),
            ),
          ),
          Text(
            "Contact us today to book your free trial session.",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 12,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.wechat_outlined,
                size: 17,
                color: Colors.white,
              ),
              const SizedBox(width: 10,),
              Text(
                "09 123 456 789",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook_outlined,
                size: 17,
                color: Colors.white,
              ),
              const SizedBox(width: 10,),
              Text(
                "Badminton Pro Training Center",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.location_on_rounded,
                size: 17,
                color: Colors.white,
              ),
              const SizedBox(width: 10,),
              Text(
                "Bahan, Yangon",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 12,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
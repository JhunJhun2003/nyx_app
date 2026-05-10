import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class badmintonRantalState extends StatefulWidget {
  const badmintonRantalState({super.key});

  @override
  State<badmintonRantalState> createState() => _badmintonRantalStateState();
}

class _badmintonRantalStateState extends State<badmintonRantalState> {

  int selectedIndex = 0;

  List<String> times  = [
    "6:00 - 7:00",
    "7:30 - 8:30",
    "9:00 - 10:00",
    "16:30 - 17:30",
    "18:00 - 19:00",
    "20:30 - 21:30",
  ];

  int selectedCourt = 0;

  List<String> courts = [
    "Court 1",
    "Court 2",
    "Court 3"
  ];

  List<String> images = [
    "assets/classes/Badminton.png",
    "assets/classes/Futsal.png",
    "assets/classes/Tennis.png",
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(),
              _banner(),
              _location(),
              SizedBox(height: 5),
              _bookDate(),
              SizedBox(height: 5),
              _timeSchedule(),
              SizedBox(height: 5),
              _courtSelection(),
              Divider(),
              _schedule(),
              SizedBox(height: 5),
              _rentalSection(),
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
          SizedBox(width: 20),
          Expanded(
            child: Text(
              "Court",
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

  Widget _banner() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: images.map((item) => Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(item),fit: BoxFit.cover)
            ),
          )).toList(), 
          options: CarouselOptions(
            height: 250,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 10),
            autoPlayAnimationDuration: Duration(milliseconds: 900),
            enlargeCenterPage: true,
            aspectRatio: 16/9,
            viewportFraction: 1,
            onPageChanged: (index,reason){
              setState(() {
                currentIndex = index;
              });
            }
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((item) => Container(
            height: 7,
            width: 7,
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == item.key ? Colors.black : Colors.grey,
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _location(){
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_sharp,
            color: Colors.red,
            size: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "N0.(111), Hlaing Township, Yangon.",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookDate(){
    return Container(
      height: 160,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      margin: EdgeInsets.symmetric(horizontal: 3) ,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "Select a reservation date",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Custom",
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeSchedule(){
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 5, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timer,
            color: const Color.fromARGB(255, 71, 250, 77),
            size: 30,
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              "Select a time slot & Court",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          Text(
            "5 Session Available",
            style: TextStyle(
              color: Colors.red,
              fontFamily: "Custom",
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _schedule() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: times.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 2.5,
      ),
      itemBuilder: (context, index) {
        bool isSelected =
            selectedIndex == index;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isSelected
                  ? Colors.red
                  : Colors.white,
              boxShadow: [
                BoxShadow(
                  color:
                      Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                times[index],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Custom",
                  color: isSelected
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _courtSelection(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(courts.length, (index) {
        bool isCourtSelected = selectedCourt == index;
        return Padding(
          padding: const EdgeInsets.all(2),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(130, 30),
              backgroundColor: isCourtSelected ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                selectedCourt = index;
              });
            },
            child: Text(
              courts[index],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontFamily: "Custom",
                color: isCourtSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }),
    ); 
  }

  bool _isChecked = false;

  Widget _rentalSection(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
      height: 350,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8,
            top: 5,
            child: Row(
              children: [
                Text(
                  "Rental Session",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Custom",
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  "10% OFF for 3+ sessions",
                  style: TextStyle(
                    color: Colors.red,
                    fontFamily: "Custom",
                    fontSize: 15,
                  ),
                )
              ],
            ),
          ),
          Positioned(
            left: 8,
            top: 35,
            child: _sessionCount()
          ),
          Positioned(
            left: 8,
            top: 105,
            child: Text(
              "Equipment Rental",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            )
          ),
          Positioned(
            right: 8,
            top: 105,
            child: Text(
              "Optional",
              style: TextStyle(
                color: Colors.blue,
                fontFamily: "Custom",
                fontSize: 15,
              ),
            )
          ),
          Positioned(
            left: 8,
            top: 135,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  _rentalAccessories("Pro Racket", "2,000 Ks/hour"),
                  SizedBox(height: 5),
                  _rentalAccessories("Court Shoes", "3,000 Ks/hour"),
                  SizedBox(height: 5),
                  _rentalAccessories("Shuttlecock", "1,500 Ks/piece"),
                  SizedBox(height: 5),
                  _rentalAccessories("Jersey", "3,000 Ks/piece"),
                ]
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: -0,
            child: Row(
              children: [
                Checkbox(
                  value: _isChecked, 
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                SizedBox(width: 5),
                Text(
                  "I agree to return all rented equipment in its original condition.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Custom",
                    fontSize: 12
                  ),
                )
              ],
            )
          ),
        ],
      ),
    );
  }

  Widget _sessionCount(){
    return Container(
      width: 390,
      height: 60,
      padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10,
            top: -70,
            child: GestureDetector(
              onTap: (){},
              child: Text(
                "-",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 120,
                ),
              ),
            ),
          ),
          Positioned(
            right: 180,
            top: -20,
            child: GestureDetector(
              onTap: (){},
              child: Text(
                "1",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 60,
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            top: -70,
            child: GestureDetector(
              onTap: (){},
              child: Text(
                "+",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 120,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rentalAccessories(String text, String price) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: 382,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2)
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(width: 20),
          Text(
            price,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Custom",
              fontSize: 17,
            ),
          ),
          SizedBox(width: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.remove, color: Colors.white, size: 18),
              ),
              SizedBox(width: 5),
              Text(
                '0',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () {},
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
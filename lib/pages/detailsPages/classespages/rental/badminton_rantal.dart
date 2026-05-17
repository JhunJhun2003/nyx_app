import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/booking_form.dart';

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

  bool _isChecked2 = false;

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
              _schedule(),
              SizedBox(height: 5),
              _rentalSection(),
              SizedBox(height: 5),
              _service1(),
              SizedBox(height: 5),
              _service2(),
              SizedBox(height: 5),
              _ruleAndSafe(),
              _valid(),
              _confirm(),
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
              "Court Rentals",
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

  Widget _ruleAndSafe(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Court Rules & Safety",
            style: TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontFamily: "Custom",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          _safetyWidget("Footware","Arrive 10 minutes early. Bookings will be released if 15","minutes late."),
          SizedBox(height: 3),
          _safetyWidget("Grace Period","Arrive 10 minutes early. Bookings will be released if 15","minutes late."),
          SizedBox(height: 3),
          _safetyWidget("No Food/ Drinks","Only bottled water is allowed. Foods and Smoking are","strictly prohibited."),
          SizedBox(height: 3),
          _safetyWidget("Liability","Players play at their own risk. The management is not liable","for injuries."),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _service1(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Services",
            style: TextStyle(
              color: Color.fromARGB(255, 13, 27, 42),
              fontFamily: "Custom",
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: 130,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.wifi,
                      size: 50,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 14,),
                        Text("High Speed",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                        SizedBox(height: 2,),
                        Text("Free Wifi",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 130,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.shower,
                      size: 60,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 14,),
                        Text("Free",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                        SizedBox(height: 2,),
                        Text("Shower",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(width: 5),
              Container(
                width: 130,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.door_back_door,
                      size: 60,
                    ),
                    Column(
                      children: [
                        SizedBox(height: 14,),
                        Text("Locker",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                        SizedBox(height: 2,),
                        Text("Room",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _service2(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
            width: 130,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.car_repair,
                  size: 60,
                ),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Car",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                    SizedBox(height: 2,),
                    Text("Packing",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                  ],
                )
              ],
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 130,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.security,
                  size: 60,
                ),
                Text("Security",style: TextStyle(fontSize: 16,fontFamily:"Custom"),)
              ],
            ),
          ),
          SizedBox(width: 5),
          Container(
            width: 130,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.room_preferences_outlined,
                  size: 60,
                ),
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Text("Changing",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                    SizedBox(height: 2,),
                    Text("Room",style: TextStyle(fontSize: 16,fontFamily:"Custom"),),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _safetyWidget(String text1, String text2, String text3){
    return Container(
      width: 400,
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 3,),
              Text(
                text1,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                text2,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 1),
              Text(
                text3,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _valid(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked2, 
            onChanged: (bool? value) {
              setState(() {
                _isChecked2 = value!;
              });
            },
          ),
          Text(
            "I have read and agree to follow the court rules & safety guidelines.",
            style: TextStyle(
              color: const Color.fromARGB(255, 72, 72, 72),
              fontFamily: "Custom",
              fontSize: 12
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirm(){
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.red)
        ),
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => bookingForm(),
            ),
          );
        }, 
        child: Text(
          "Booking Now",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: 17,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}
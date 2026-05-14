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
  int sessionCount = 1;
  bool _isChecked = false;
  int currentIndex = 0;
  int selectedCourt = 0;
  DateTime selectedDate = DateTime.now(); // Added missing variable

  List<DateTime> getAvailableDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < 5; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
    return dates;
  }

  List<String> times = [
    "6:00 - 7:00",
    "7:30 - 8:30",
    "9:00 - 10:00",
    "16:30 - 17:30",
    "18:00 - 19:00",
    "20:30 - 21:30",
  ];

  List<String> courts = ["Court 1", "Court 2", "Court 3"];

  List<String> images = [
    "assets/classes/Badminton.png",
    "assets/classes/Futsal.png",
    "assets/classes/Tennis.png",
  ];

  // Equipment quantities
  Map<String, int> equipmentQuantities = {
    "Pro Racket": 0,
    "Court Shoes": 0,
    "Shuttlecock": 0,
    "Jersey": 0,
  };

  Map<String, String> equipmentPrices = {
    "Pro Racket": "2,000 Ks/hour",
    "Court Shoes": "3,000 Ks/hour",
    "Shuttlecock": "1,500 Ks/piece",
    "Jersey": "3,000 Ks/piece",
  };

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
              _banner(screenWidth, screenHeight),
              _location(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _bookDate(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _timeSchedule(screenWidth, screenHeight),
              _schedule(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _rentalSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _confirm(screenWidth, screenHeight),
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
              "Court Rentals",
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

  Widget _banner(double screenWidth, double screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider(
          items: images.map((item) => Container(
            margin: EdgeInsets.all(screenWidth * 0.01),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item),
                fit: BoxFit.cover,
              ),
            ),
          )).toList(),
          options: CarouselOptions(
            height: screenHeight * 0.28,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 10),
            autoPlayAnimationDuration: const Duration(milliseconds: 900),
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: images.asMap().entries.map((item) => Container(
            height: screenHeight * 0.008,
            width: screenWidth * 0.02,
            margin: EdgeInsets.all(screenWidth * 0.01),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: currentIndex == item.key ? Colors.black : Colors.grey,
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _location(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on_sharp,
            color: Colors.red,
            size: screenWidth * 0.07,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              "No.(111), Hlaing Township, Yangon.",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookDate(double screenWidth, double screenHeight) {
    List<DateTime> dates = getAvailableDates();
    List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri"];

    return Container(
       height: 120,
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      margin: EdgeInsets.symmetric(horizontal: 3) ,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 13, 27, 42),
        // borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
                ),
                SizedBox(width: screenHeight * 0.012),
            Text(
              "Select a reservation date",
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),],
            ),
            SizedBox(height: screenHeight * 0.012),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dates.length, (index) {
                bool isSelected = selectedDate.day == dates[index].day;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = dates[index];
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.17,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          weekDays[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontSize: screenWidth * 0.032,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.003),
                        Text(
                          dates[index].day.toString(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeSchedule(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.timer,
            color: const Color.fromARGB(255, 71, 250, 77),
            size: screenWidth * 0.07,
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Text(
              "Select a time slot & Court",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Text(
          //   "${times.length} Session Available",
          //   style: TextStyle(
          //     color: Colors.red,
          //     fontFamily: "Custom",
          //     fontSize: screenWidth * 0.035,
          //     fontWeight: FontWeight.w500,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _schedule(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        children: [
          // Time slots grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: times.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: screenWidth * 0.02,
              mainAxisSpacing: screenHeight * 0.01,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              bool isSelected = selectedIndex == index;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(0),
                    color: isSelected ? Colors.red : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      times[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Custom",
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _rentalSection(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.02,
        vertical: screenHeight * 0.01,
      ),
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Equipment Rental Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Equipment Rental",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          // Equipment List
          ...equipmentQuantities.keys.map((equipment) {
            return Padding(
              padding: EdgeInsets.only(bottom: screenHeight * 0.01),
              child: _rentalAccessories(
                equipment,
                equipmentPrices[equipment]!,
                equipmentQuantities[equipment]!,
                screenWidth,
                screenHeight,
              ),
            );
          }),
          SizedBox(height: screenHeight * 0.02),
          // Checkbox
          Row(
            children: [
              Checkbox(
                value: _isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    _isChecked = value!;
                  });
                },
                activeColor: Colors.red,
              ),
              Expanded(
                child: Text(
                  "I agree to return all rented equipment in its original condition.",
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: "Custom",
                    fontSize: screenWidth * 0.03,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sessionCount(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                if (sessionCount > 1) sessionCount--;
              });
            },
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
            ),
          ),
          Text(
            sessionCount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Custom",
              fontSize: screenWidth * 0.08,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                sessionCount++;
              });
            },
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.03),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: screenWidth * 0.06,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _rentalAccessories(String text, String price, int quantity, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.008),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
          // Product Name - Fixed width
          SizedBox(
            width: screenWidth * 0.25,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: screenWidth * 0.035,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Price - Fixed width
          SizedBox(
            width: screenWidth * 0.25,
            child: Text(
              price,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Custom",
                fontSize: screenWidth * 0.03,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Quantity controls - Flexible
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (equipmentQuantities[text]! > 0) {
                        equipmentQuantities[text] = equipmentQuantities[text]! - 1;
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.remove, color: Colors.white, size: screenWidth * 0.04),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                SizedBox(
                  width: screenWidth * 0.08,
                  child: Text(
                    equipmentQuantities[text].toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.02),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      equipmentQuantities[text] = equipmentQuantities[text]! + 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.01),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.04),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _confirm(double screenWidth, double screenHeight) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.015,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const bookingForm(),
            ),
          );
        },
        child: Text(
          "Booking Now",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
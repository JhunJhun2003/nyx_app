import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/walkinbooking_form.dart';

class WalkInCourt extends StatefulWidget {
  WalkInCourt({super.key});

  @override
  State<WalkInCourt> createState() => _WalkInCourtState();
}

class _WalkInCourtState extends State<WalkInCourt> {
  DateTime selectedDate = DateTime.now();
  int currentIndex = 0;
  bool _isChecked2 = false;

  final _availableSlots = [
    "6:00 - 7:00",
    "7:30 - 8:30",
    "9:00 - 10:00",
    "16:00 - 17:00",
    "17:30 - 18:30",
    "19:00 - 20:00",
  ];

  List<DateTime> getAvailableDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < 5; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
    return dates;
  }

  String _formatTime(String time) {
    if (time.isEmpty) return "";
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    return "$hour:${parts[1]}";
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _header(screenWidth, screenHeight),
              _banner(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _location(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _bookDate(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _timeSchedule(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _schedule(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _valid(screenWidth, screenHeight),
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
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: screenWidth * 0.05,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          SizedBox(width: screenWidth * 0.03),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Badminton Court",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.white,
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "25,000 Ks / hour",
                style: TextStyle(
                  fontFamily: "Custom",
                  color: Colors.white70,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ],
          ),
        ],
      ),
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

  Widget _banner(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      width: screenWidth,
      height: screenHeight * 0.25,
      decoration: BoxDecoration(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          "assets/images/badminton_court.jpg",
          fit: BoxFit.cover,
          height: screenHeight * 0.25,
          width: screenWidth,
        ),
      ),
    );
  }

  Widget _bookDate(double screenWidth, double screenHeight) {
    List<DateTime> dates = getAvailableDates();
    List<String> getWeekDays() {
      List<String> weekDays = [];
      DateTime now = DateTime.now();
      for (int i = 0; i < 5; i++) {
        DateTime date = now.add(Duration(days: i));
        weekDays.add(_getDayName(date.weekday));
      }
      return weekDays;
    }

    List<String> weekDays = getWeekDays();

    return Container(
      height: screenHeight * 0.14,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
        horizontal: screenWidth * 0.01,
      ),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      decoration: BoxDecoration(
        // color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                  size: screenWidth * 0.05,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "Select a reservation date",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 13, 27, 42),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(dates.length, (index) {
                bool isSelected =
                    selectedDate.day == dates[index].day &&
                    selectedDate.month == dates[index].month &&
                    selectedDate.year == dates[index].year;
                return GestureDetector(
                  onTap: () {
                    // if (mounted) {
                    //   setState(() {
                    //     selectedDate = dates[index];
                    //     selectedTimeSlot = null;
                    //   });
                    //   _loadAvailableSlots();
                    // }
                  },
                  child: Container(
                    width: screenWidth * 0.17,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? Colors.red
                            : Color.fromARGB(255, 13, 27, 42),
                        width: 2,
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

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";
      default:
        return "Mon";
    }
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
              "Select Time Slot",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: screenWidth * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // if (selectedTimeSlot != null)
          //   Text(
          //     "1 selected",
          //     style: TextStyle(
          //       color: Colors.red,
          //       fontSize: screenWidth * 0.035,
          //       fontWeight: FontWeight.w500,
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _confirm(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(right: 30),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.1,
            vertical: screenHeight * 0.01,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // _checkLoginAndProceed();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WalkInBookingForm()),
          );
        },
        child: Text(
          "Booking Now",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Custom",
            fontSize: screenWidth * 0.04,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _valid(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Row(
        children: [
          Checkbox(
            value: _isChecked2,
            onChanged: (bool? value) {
              if (mounted)
                setState(() {
                  _isChecked2 = value!;
                });
            },
            activeColor: Colors.red,
          ),
          Expanded(
            child: Text(
              "I have read and agree to follow the court rules & safety guidelines.",
              style: TextStyle(
                color: Colors.grey.shade800,
                fontFamily: "Custom",
                fontSize: screenWidth * 0.03,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _schedule(double screenWidth, double screenHeight) {
    // if (_isLoadingSlots) {
    //   return const Padding(
    //     padding: EdgeInsets.all(20),
    //     child: Center(child: CircularProgressIndicator()),
    //   );
    // }
    // if (_slotsError != null) {
    //   return Padding(
    //     padding: const EdgeInsets.all(20),
    //     child: Center(
    //       child: Column(
    //         children: [
    //           Text(
    //             "Error!",
    //             style: const TextStyle(color: Colors.red),
    //             textAlign: TextAlign.center,
    //           ),
    //           const SizedBox(height: 10),
    //           ElevatedButton(
    //             onPressed: () {},
    //             style: ElevatedButton.styleFrom(
    //               backgroundColor: Colors.red,
    //               foregroundColor: Colors.white,
    //             ),
    //             child: const Text('Retry'),
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }
    // if (_availableSlots.isEmpty) {
    //   return const Padding(
    //     padding: EdgeInsets.all(20),
    //     child: Center(
    //       child: Text(
    //         "No available time slots for selected date",
    //         style: TextStyle(color: Colors.red),
    //       ),
    //     ),
    //   );
    // }

    // List<String> formattedSlots = _availableSlots.map((slot) {
    //   return "${_formatTime(slot.startTime)} - ${_formatTime(slot.endTime)}";
    // }).toList();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _availableSlots.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: screenWidth * 0.02,
              mainAxisSpacing: screenHeight * 0.01,
              childAspectRatio: 2.2,
            ),
            itemBuilder: (context, index) {
              // bool isSelected = selectedTimeSlot == _availableSlots[index];
              return GestureDetector(
                onTap: () {
                  // setState(() {
                  //   selectedTimeSlot = _availableSlots[index];
                  // });
                },
                child: Container(
                  margin: EdgeInsets.all(screenWidth * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      _availableSlots[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Custom",
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // if (selectedTimeSlot != null)
          //   Padding(
          //     padding: EdgeInsets.only(top: screenHeight * 0.01),
          //     child: Text(
          //       "Selected: 1 session - Total: ${courtPrice.toStringAsFixed(0)} Ks",
          //       style: TextStyle(
          //         color: Colors.red,
          //         fontSize: screenWidth * 0.035,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nyxproject/Util/RentelApi/VenueApi.dart';
import 'package:nyxproject/pages/detailsPages/classespages/rental/booking_form.dart';
import 'package:nyxproject/models/Venue.dart';
import 'package:nyxproject/models/Court.dart';

class badmintonRantalState extends StatefulWidget {
  final Venue? selectedVenue;
  final Court? selectedCourt;

  const badmintonRantalState({
    super.key,
    this.selectedVenue,
    this.selectedCourt,
  });

  @override
  State<badmintonRantalState> createState() => _badmintonRantalStateState();
}

class _badmintonRantalStateState extends State<badmintonRantalState> {
  int selectedIndex = 0;
  int sessionCount = 1;
  bool _isChecked = false;
  int currentIndex = 0;
  int selectedVenueIndex = 0;
  DateTime selectedDate = DateTime.now();
  bool _isChecked2 = false;
  
  List<Venue> venues = [];
  bool _isLoadingVenues = true;
  String? _venuesError;

  // Get court price from selectedCourt or use default
  double get courtPrice {
    if (widget.selectedCourt != null) {
      return widget.selectedCourt!.hourlyPrice.toDouble();
    }
    if (widget.selectedVenue != null) {
      return widget.selectedVenue!.price.toDouble();
    }
    if (venues.isNotEmpty && selectedVenueIndex < venues.length) {
      return venues[selectedVenueIndex].price.toDouble();
    }
    return 25000;
  }

  // Get court name
  String get courtName {
    if (widget.selectedCourt != null) {
      return widget.selectedCourt!.courtName;
    }
    if (widget.selectedVenue != null) {
      return widget.selectedVenue!.venueName;
    }
    if (venues.isNotEmpty && selectedVenueIndex < venues.length) {
      return venues[selectedVenueIndex].venueName;
    }
    return "Badminton Court";
  }

  List<DateTime> getAvailableDates() {
    List<DateTime> dates = [];
    for (int i = 0; i < 5; i++) {
      dates.add(DateTime.now().add(Duration(days: i)));
    }
    return dates;
  }

  // Get time slots from selectedCourt or use default
  List<String> getTimeSlots() {
    if (widget.selectedCourt != null && 
        widget.selectedCourt!.timeSlots != null && 
        widget.selectedCourt!.timeSlots!.isNotEmpty) {
      return widget.selectedCourt!.timeSlots!.map((slot) {
        return "${_formatTime(slot.startTime)} - ${_formatTime(slot.endTime)}";
      }).toList();
    }
    return [
      "6:00 - 7:00",
      "7:30 - 8:30",
      "9:00 - 10:00",
      "16:30 - 17:30",
      "18:00 - 19:00",
      "20:30 - 21:30",
    ];
  }

  String _formatTime(String time) {
    if (time.isEmpty) return "";
    // Format "06:00:00" to "6:00"
    List<String> parts = time.split(':');
    int hour = int.parse(parts[0]);
    return "$hour:${parts[1]}";
  }

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
  void initState() {
    super.initState();
    // Only load venues if no court or venue was passed
    if (widget.selectedCourt == null && widget.selectedVenue == null) {
      _loadVenues();
    } else {
      _isLoadingVenues = false;
    }
  }

  Future<void> _loadVenues() async {
    setState(() {
      _isLoadingVenues = true;
      _venuesError = null;
    });

    try {
      final result = await VenueApi.getAllVenues();

      if (result['success'] == true) {
        setState(() {
          venues = result['data'] ?? [];
          _isLoadingVenues = false;
        });
        print('✅ Loaded ${venues.length} venues');
      } else {
        setState(() {
          _venuesError = result['message'] ?? 'Failed to load venues';
          _isLoadingVenues = false;
        });
      }
    } catch (e) {
      setState(() {
        _venuesError = 'Error loading venues: $e';
        _isLoadingVenues = false;
      });
    }
  }

  double getSessionPrice() {
    double basePrice = courtPrice;
    if (sessionCount >= 3) {
      return basePrice * sessionCount * 0.9;
    }
    return basePrice * sessionCount;
  }

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
              if (widget.selectedCourt == null && widget.selectedVenue == null)
                _venueSelection(screenWidth, screenHeight),
              _schedule(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _rentalSessionSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _rentalSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _serviceSection(screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.01),
              _ruleAndSafe(screenWidth, screenHeight),
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
              courtName,
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
      height: screenHeight * 0.16,
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01, horizontal: screenWidth * 0.01),
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month_outlined, color: Colors.white, size: screenWidth * 0.05),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  "Select a reservation date",
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.01),
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
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
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
        ],
      ),
    );
  }

  Widget _venueSelection(double screenWidth, double screenHeight) {
    if (_isLoadingVenues) {
      return Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_venuesError != null) {
      return Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            Text(
              _venuesError!,
              style: const TextStyle(color: Colors.red),
            ),
            SizedBox(height: screenHeight * 0.01),
            ElevatedButton(
              onPressed: _loadVenues,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (venues.isEmpty) {
      return Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: const Text('No venues available'),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Court",
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          SizedBox(
            height: screenHeight * 0.12,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: venues.length,
              itemBuilder: (context, index) {
                final venue = venues[index];
                bool isSelected = selectedVenueIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVenueIndex = index;
                    });
                  },
                  child: Container(
                    width: screenWidth * 0.4,
                    margin: EdgeInsets.only(right: screenWidth * 0.02),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.red : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected ? Colors.red : Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            venue.venueImageUrl,
                            width: screenWidth * 0.15,
                            height: screenHeight * 0.1,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: screenWidth * 0.15,
                                height: screenHeight * 0.1,
                                color: Colors.grey,
                                child: const Icon(Icons.sports),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                venue.venueName,
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                              Text(
                                "${venue.price.toString()} Ks",
                                style: TextStyle(
                                  color: isSelected ? Colors.white70 : Colors.red,
                                  fontSize: screenWidth * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _schedule(double screenWidth, double screenHeight) {
    List<String> timeSlots = getTimeSlots();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timeSlots.length,
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
                      timeSlots[index],
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

  Widget _rentalSessionSection(double screenWidth, double screenHeight) {
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
          Row(
            children: [
              Text(
                "Rental Session",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.02,
                  vertical: screenHeight * 0.003,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade700,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  "10% OFF for 3+ sessions",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.015),
          _sessionCount(screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget _sessionCount(double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(12),
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
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.remove,
                color: Colors.white,
                size: screenWidth * 0.05,
              ),
            ),
          ),
          Column(
            children: [
              Text(
                "$sessionCount SESSION${sessionCount > 1 ? 'S' : ''}",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Custom",
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${getSessionPrice().toStringAsFixed(0)} Ks",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: screenWidth * 0.03,
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                sessionCount++;
              });
            },
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: screenWidth * 0.05,
              ),
            ),
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

  Widget _rentalAccessories(String text, String price, int quantity, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.008),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 1),
      ),
      child: Row(
        children: [
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
          SizedBox(width: screenWidth * 0.05),
          Text(
            price,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04,
            ),
          ),
          SizedBox(width: screenWidth * 0.05),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (equipmentQuantities[text]! > 0) {
                      equipmentQuantities[text] = equipmentQuantities[text]! - 1;
                    }
                  });
                },
                child: const Icon(Icons.remove, color: Colors.white, size: 18),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                equipmentQuantities[text].toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: screenWidth * 0.02),
              GestureDetector(
                onTap: () {
                  setState(() {
                    equipmentQuantities[text] = equipmentQuantities[text]! + 1;
                  });
                },
                child: const Icon(Icons.add, color: Colors.white, size: 18),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _serviceSection(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Additional Services",
            style: TextStyle(
              color: const Color.fromARGB(255, 13, 27, 42),
              fontFamily: "Custom",
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _serviceCard(Icons.wifi, "High Speed", "Free Wifi", screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.02),
                _serviceCard(Icons.shower, "Free", "Shower", screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.02),
                _serviceCard(Icons.door_back_door, "Locker", "Room", screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.02),
                _serviceCard(Icons.car_repair, "Car", "Parking", screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.02),
                _serviceCard(Icons.security, "Security", "", screenWidth, screenHeight),
                SizedBox(width: screenWidth * 0.02),
                _serviceCard(Icons.room_preferences_outlined, "Changing", "Room", screenWidth, screenHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _serviceCard(IconData icon, String line1, String line2, double screenWidth, double screenHeight) {
    return Container(
      width: screenWidth * 0.35,
      height: screenHeight * 0.11,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: screenWidth * 0.1),
          SizedBox(width: screenWidth * 0.02),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(line1, style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: "Custom")),
              if (line2.isNotEmpty) ...[
                SizedBox(height: screenHeight * 0.005),
                Text(line2, style: TextStyle(fontSize: screenWidth * 0.04, fontFamily: "Custom")),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _ruleAndSafe(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Court Rules & Safety",
            style: TextStyle(
              color: const Color.fromARGB(255, 13, 27, 42),
              fontFamily: "Custom",
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          _safetyWidget("Footwear", "Arrive 10 minutes early. Bookings will be released if 15", "minutes late.", screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.005),
          _safetyWidget("Grace Period", "Arrive 10 minutes early. Bookings will be released if 15", "minutes late.", screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.005),
          _safetyWidget("No Food/Drinks", "Only bottled water is allowed. Foods and Smoking are", "strictly prohibited.", screenWidth, screenHeight),
          SizedBox(height: screenHeight * 0.005),
          _safetyWidget("Liability", "Players play at their own risk. The management is not liable", "for injuries.", screenWidth, screenHeight),
        ],
      ),
    );
  }

  Widget _safetyWidget(String title, String desc1, String desc2, double screenWidth, double screenHeight) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 13, 27, 42),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Custom",
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            desc1,
            style: TextStyle(
              color: Colors.white70,
              fontFamily: "Custom",
              fontSize: screenWidth * 0.035,
            ),
          ),
          Text(
            desc2,
            style: TextStyle(
              color: Colors.white70,
              fontFamily: "Custom",
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
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
                color: Colors.grey.shade600,
                fontFamily: "Custom",
                fontSize: screenWidth * 0.03,
              ),
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
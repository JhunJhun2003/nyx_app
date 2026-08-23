import 'package:flutter/material.dart';
// import 'package:nyxproject/pages/detailsPages/servicepages/rental/court_details.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/walkin_courtNumber.dart';
// import 'package:nyxproject/models/Venue.dart';
import 'package:path/path.dart';

class WalkInScreen extends StatefulWidget {
  const WalkInScreen({super.key});

  @override
  State<WalkInScreen> createState() => _WalkInScreenState();
}

class _WalkInScreenState extends State<WalkInScreen> {
  final name = "Court One";
  final price = "25,000 Ks";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Walk-In",
              style: TextStyle(
                fontSize: 19,
                fontFamily: "Custom",
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: const Text(
              "Enjoy your private court.",
              style: TextStyle(
                fontSize: 15,
                fontFamily: "Custom",
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildVenueCard(context),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget _buildVenueList() {
  // if (isLoadingVenues) {
  //   return const Center(
  //     child: Padding(
  //       padding: EdgeInsets.all(20),
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

  // if (venuesError != null) {
  //   return Center(
  //     child: Padding(
  //       padding: const EdgeInsets.all(20),
  //       child: Column(
  //         children: [
  //           Text(venuesError!, style: const TextStyle(color: Colors.red)),
  //           const SizedBox(height: 10),
  //           ElevatedButton(
  //             onPressed: onRetryVenues,
  //             style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  //             child: const Text(
  //               'Retry',
  //               style: TextStyle(color: Colors.white),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // if (venues.isEmpty) {
  //   return const Center(
  //     child: Padding(
  //       padding: EdgeInsets.all(20),
  //       child: Text('No venues available'),
  //     ),
  //   );
  // }

  //   return _buildVenueCard(context);
  // }

  Widget _buildVenueCard(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () {
        // Navigate to Courts page with venueId and venueName
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) =>
        //         Courts(venueId: venue.id, venueName: venue.venueName),
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WalkInCourts()),
        );
      },
      child: Container(
        height: screenHeight * 0.33,
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.0125,
          vertical: screenHeight * 0.01,
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 13, 27, 42),
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
                  height: screenHeight * 0.25,
                  width: screenWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenHeight * 0.25,
                      width: screenWidth,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.sports,
                        size: 50,
                        color: Colors.white54,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: screenWidth * 0.025,
              bottom: screenHeight * 0.08,
              child: Text(
                name,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontFamily: "Custom",
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: screenWidth * 0.025,
              bottom: screenHeight * 0.08,
              child: Text(
                price,
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
              child: Container(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                width: screenWidth * 0.95,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Show Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Custom",
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

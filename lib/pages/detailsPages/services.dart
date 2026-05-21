// lib/pages/detailsPages/classes.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Canteen.dart';
import 'package:nyxproject/models/Venue.dart';
import 'package:nyxproject/pages/detailsPages/widgets/servicesWidgets/canteen_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/servicesWidgets/rentals_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/servicesWidgets/tab_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/servicesWidgets/trainings_widget.dart';
import 'package:nyxproject/util/CanteenApi.dart';
import 'package:nyxproject/Util/RentelApi/VenueApi.dart';  // Add this import

class Services extends StatefulWidget {
  const Services({super.key});

  @override
  State<Services> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<Services> {
  int selectedIndex = 0;
  
  // Canteen variables
  List<Canteen> _canteenItems = [];
  bool _isLoadingCanteen = true;
  String? _canteenError;

  // Rental/Venue variables
  List<Venue> _venues = [];
  bool _isLoadingVenues = true;
  String? _venuesError;

  @override
  void initState() {
    super.initState();
    _loadCanteenItems();
    _loadVenues();
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }

  Future<void> _loadCanteenItems() async {
    // Check if widget is still mounted before setState
    if (!mounted) return;
    
    setState(() {
      _isLoadingCanteen = true;
      _canteenError = null;
    });

    try {
      final result = await CanteenApi.getAllCanteenItems();

      // Check again after async operation
      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _canteenItems = result['data'] ?? [];
          _isLoadingCanteen = false;
        });
        print('✅ Loaded ${_canteenItems.length} canteen items');
      } else {
        setState(() {
          _canteenError = result['message'] ?? 'Failed to load canteen items';
          _isLoadingCanteen = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _canteenError = 'Error loading canteen items: $e';
        _isLoadingCanteen = false;
      });
    }
  }

  Future<void> _loadVenues() async {
    // Check if widget is still mounted before setState
    if (!mounted) return;
    
    setState(() {
      _isLoadingVenues = true;
      _venuesError = null;
    });

    try {
      final result = await VenueApi.getAllVenues();

      // Check again after async operation
      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _venues = result['data'] ?? [];
          _isLoadingVenues = false;
        });
        print('✅ Loaded ${_venues.length} venues');
      } else {
        setState(() {
          _venuesError = result['message'] ?? 'Failed to load venues';
          _isLoadingVenues = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _venuesError = 'Error loading venues: $e';
        _isLoadingVenues = false;
      });
    }
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
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TabWidget(
                    title: "TRAININGS",
                    index: 0,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      if (mounted) {
                        setState(() => selectedIndex = 0);
                      }
                    },
                  ),
                  TabWidget(
                    title: "RENTALS",
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      if (mounted) {
                        setState(() => selectedIndex = 1);
                      }
                    },
                  ),
                  TabWidget(
                    title: "CANTEEN",
                    index: 2,
                    selectedIndex: selectedIndex,
                    onTap: () {
                      if (mounted) {
                        setState(() => selectedIndex = 2);
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 15),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: selectedIndex == 0
                    ? const TrainingsWidget()
                    : selectedIndex == 1
                    ? RentalsWidget(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        venues: _venues,
                        isLoadingVenues: _isLoadingVenues,
                        venuesError: _venuesError,
                        onRetryVenues: _loadVenues,
                      )
                    : CanteenWidget(
                        items: _canteenItems,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        isLoading: _isLoadingCanteen,
                        error: _canteenError,
                        onRetry: _loadCanteenItems,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
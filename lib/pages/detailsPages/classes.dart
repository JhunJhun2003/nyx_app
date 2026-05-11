// lib/pages/detailsPages/classes.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Canteen.dart';
import 'package:nyxproject/pages/detailsPages/widgets/classesWidgets/canteen_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/classesWidgets/rentals_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/classesWidgets/tab_widget.dart';
import 'package:nyxproject/pages/detailsPages/widgets/classesWidgets/trainings_widget.dart';
import 'package:nyxproject/util/CanteenApi.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  int selectedIndex = 0;
  
  // Canteen variables
  List<Canteen> _canteenItems = [];
  bool _isLoadingCanteen = true;
  String? _canteenError;

  @override
  void initState() {
    super.initState();
    _loadCanteenItems();
  }

  Future<void> _loadCanteenItems() async {
    setState(() {
      _isLoadingCanteen = true;
      _canteenError = null;
    });

    try {
      final result = await CanteenApi.getAllCanteenItems();

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
      setState(() {
        _canteenError = 'Error loading canteen items: $e';
        _isLoadingCanteen = false;
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
                    onTap: () => setState(() => selectedIndex = 0),
                  ),
                  TabWidget(
                    title: "RENTALS",
                    index: 1,
                    selectedIndex: selectedIndex,
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  TabWidget(
                    title: "CANTEEN",
                    index: 2,
                    selectedIndex: selectedIndex,
                    onTap: () => setState(() => selectedIndex = 2),
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

//widgets are in the classesWidgets folder 
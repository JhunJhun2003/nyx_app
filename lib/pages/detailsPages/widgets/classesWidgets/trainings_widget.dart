// lib/pages/detailsPages/classesWidgets/trainings_widget.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/pages/detailsPages/classespages/badminton_class.dart';
import 'package:nyxproject/pages/detailsPages/classespages/futsal_class.dart';
import 'package:nyxproject/pages/detailsPages/classespages/tennis_class.dart';

class TrainingsWidget extends StatelessWidget {
  const TrainingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _buildTrainingCard(
            context,
            "assets/classes/Badminton.png",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BadmintonClass()),
            ),
          ),
          _buildTrainingCard(
            context,
            "assets/classes/Futsal.png",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const futsalClass()),
            ),
          ),
          _buildTrainingCard(
            context,
            "assets/classes/Tennis.png",
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const tennisClass()),
            ),
          ),
        ],
        key: const ValueKey("training"),
      ),
    );
  }

  Widget _buildTrainingCard(
    BuildContext context,
    String imagePath,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(7, 5),
            ),
          ],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
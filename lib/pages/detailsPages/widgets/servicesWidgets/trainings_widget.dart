// lib/pages/detailsPages/classesWidgets/trainings_widget.dart
import 'package:flutter/material.dart';
import 'package:nyxproject/models/Training.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/classes/class_details.dart';
import 'package:nyxproject/Util/ClassApi/TrainingApi.dart';

class TrainingsWidget extends StatefulWidget {
  const TrainingsWidget({super.key});

  @override
  State<TrainingsWidget> createState() => _TrainingsWidgetState();
}

class _TrainingsWidgetState extends State<TrainingsWidget> {
  List<Training> _trainings = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTrainings();
  }

  Future<void> _loadTrainings() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await TrainingApi.getAllTrainings();

      if (!mounted) return;

      if (result['success'] == true) {
        setState(() {
          _trainings = result['data'] ?? [];
          _isLoading = false;
        });
        print('✅ Loaded ${_trainings.length} trainings');
      } else {
        setState(() {
          _error = result['message'] ?? 'Failed to load trainings';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error loading trainings: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _loadTrainings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (_trainings.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Text('No trainings available'),
        ),
      );
    }

    return Center(
      child: Column(
        children: _trainings.map((training) {
          return _buildTrainingCard(
            context,
            training.mainProgramBannerImageUrl,
            training.id,  // Pass only the training ID
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ClassDetails(
                  trainingId: training.id,  // Pass only the ID
                ),
              ),
            ),
          );
        }).toList(),
        key: const ValueKey("training"),
      ),
    );
  }

  Widget _buildTrainingCard(
    BuildContext context,
    String imageUrl,
    int trainingId,
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
            image: imageUrl.isNotEmpty
                ? NetworkImage(imageUrl) as ImageProvider
                : const AssetImage("assets/classes/Badminton.png"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
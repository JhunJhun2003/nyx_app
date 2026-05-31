import 'package:flutter/material.dart';
import 'package:nyxproject/models/TrainingDetail.dart';
import 'package:nyxproject/pages/detailsPages/servicepages/classes/enrollForm.dart';
import 'package:nyxproject/Util/ClassApi/TrainingDetailApi.dart';

class ClassDetails extends StatefulWidget {
  final int trainingId;

  const ClassDetails({super.key, required this.trainingId});

  @override
  State<ClassDetails> createState() => _ClassDetailsState();
}

class _ClassDetailsState extends State<ClassDetails> {
  TrainingDetail? _trainingDetail;
  bool _isLoading = true;
  String? _error;
  final ValueNotifier<int> _selectedLevelIndex = ValueNotifier(0);
  Map<int, List<Schedule>> _schedulesByLevelId = {};

  @override
  void initState() {
    super.initState();
    _loadTrainingDetail();
  }

  @override
  void dispose() {
    _selectedLevelIndex.dispose();
    super.dispose();
  }

  int _cacheWidth(BuildContext context, {double factor = 1.0}) {
    return (MediaQuery.sizeOf(context).width *
            factor *
            MediaQuery.devicePixelRatioOf(context))
        .round();
  }

  void _buildScheduleIndex(TrainingDetail detail) {
    final indexed = <int, List<Schedule>>{};
    for (final schedule in detail.schedules) {
      indexed.putIfAbsent(schedule.trainingLevelId, () => []).add(schedule);
    }
    _schedulesByLevelId = indexed;
  }

  Future<void> _loadTrainingDetail() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final result = await TrainingDetailApi.getTrainingDetail(
        widget.trainingId,
      );

      if (!mounted) return;

      if (result['success'] == true) {
        final detail = result['data'] as TrainingDetail;
        _buildScheduleIndex(detail);
        _selectedLevelIndex.value = 0;
        setState(() {
          _trainingDetail = detail;
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = result['message'] ?? 'Failed to load training detail';
          _isLoading = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'Error loading training detail: $e';
        _isLoading = false;
      });
    }
  }

  String _formatTime(String time) {
    if (time.isEmpty) return "";
    try {
      List<String> parts = time.split(':');
      int hour = int.parse(parts[0]);
      String minute = parts[1];
      String period = hour >= 12 ? "PM" : "AM";
      int displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return "$displayHour:$minute $period";
    } catch (e) {
      return time;
    }
  }

  List<Schedule> _getSchedulesForLevel(int levelId) {
    return _schedulesByLevelId[levelId] ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _loadTrainingDetail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_trainingDetail == null) {
      return const Scaffold(
        body: SafeArea(
          child: Center(child: Text('No training data available')),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Sticky Header - stays at top when scrolling
          SliverAppBar(
            pinned: true, // This makes the header stick to the top
            backgroundColor: const Color.fromARGB(255, 13, 27, 42),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
            ),
            title: Text(
              _trainingDetail?.courseName ?? "Training Details",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "Custom",
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.bookmark,
                  color: Colors.white,
                ),
              ),
            ],
            elevation: 0,
          ),
          
          // Scrollable Content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                _imageSpace(),
                const SizedBox(height: 5),
                _section("Training Level"),
                const SizedBox(height: 5),
                ValueListenableBuilder<int>(
                  valueListenable: _selectedLevelIndex,
                  builder: (context, selectedIndex, _) =>
                      _buildLevelCards(selectedIndex),
                ),
                const SizedBox(height: 5),
                _section("Training Schedules"),
                const SizedBox(height: 5),
                ValueListenableBuilder<int>(
                  valueListenable: _selectedLevelIndex,
                  builder: (context, selectedIndex, _) =>
                      _timeTable(selectedIndex),
                ),
                const SizedBox(height: 5),
                _section("What You'll Learn"),
                const SizedBox(height: 5),
                _learning(),
                const SizedBox(height: 5),
                _section("Meet Your Coach"),
                const SizedBox(height: 5),
                _coach(),
                const SizedBox(height: 5),
                _section("Exclusive Opening Offer"),
                const SizedBox(height: 5),
                _offer(),
                const SizedBox(height: 5),
                ValueListenableBuilder<int>(
                  valueListenable: _selectedLevelIndex,
                  builder: (context, selectedIndex, _) =>
                      _enroll(selectedIndex),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomBar(),
    );
  }

  Widget _imageSpace() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: _trainingDetail?.categoryCardImageUrl.isNotEmpty == true
            ? ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  _trainingDetail!.categoryCardImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  cacheWidth: _cacheWidth(context),
                  gaplessPlayback: true,
                  filterQuality: FilterQuality.medium,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/classes/Badminton.png",
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
            : Image.asset("assets/classes/Badminton.png", fit: BoxFit.cover),
      ),
    );
  }

  Widget _section(String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border(left: BorderSide(width: 10, color: Colors.red)),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 13, 27, 42),
          fontWeight: FontWeight.w600,
          fontFamily: 'Custom',
        ),
      ),
    );
  }

  Widget _buildLevelCards(int selectedIndex) {
    final levels = _trainingDetail?.levels ?? [];

    if (levels.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No training levels available'),
      );
    }

    return SizedBox(
      height: 260,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        cacheExtent: 200,
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final level = levels[index];
          final isSelected = selectedIndex == index;
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 5),
            child: _trainingCard(
              title: level.titleLevel,
              price: level.price,
              isSelected: isSelected,
              onTap: () {
                if (_selectedLevelIndex.value != index) {
                  _selectedLevelIndex.value = index;
                }
              },
            ),
          );
        },
      ),
    );
  }

  Widget _trainingCard({
    required String title,
    required int price,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : const Color(0xFF0D1B2A),
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? Border.all(color: Colors.red, width: 2) : null,
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
              child: Icon(
                title.toLowerCase().contains('beginner')
                    ? Icons.sports
                    : title.toLowerCase().contains('intermediate')
                    ? Icons.flash_on
                    : Icons.emoji_events,
                color: Colors.black,
                size: 28,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              "Comprehensive training",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 135, 244, 139),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "$price Ks/month",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _timeTable(int selectedIndex) {
    final levels = _trainingDetail?.levels ?? [];
    final selectedLevel = levels.isNotEmpty && selectedIndex < levels.length
        ? levels[selectedIndex]
        : null;

    final schedules = selectedLevel != null
        ? _getSchedulesForLevel(selectedLevel.id)
        : [];

    if (schedules.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No schedules available for this level',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1B2A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: schedules.map((schedule) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    _getDayName(schedule.day),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    "${_formatTime(schedule.startTime)} - ${_formatTime(schedule.endTime)}",
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _getDayName(String day) {
    switch (day.toLowerCase()) {
      case 'mon':
        return 'Monday';
      case 'tue':
        return 'Tuesday';
      case 'wed':
        return 'Wednesday';
      case 'thu':
        return 'Thursday';
      case 'fri':
        return 'Friday';
      case 'sat':
        return 'Saturday';
      case 'sun':
        return 'Sunday';
      default:
        return day;
    }
  }

  Widget _learning() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _trainingDetail?.learningDescription ??
                      "Technical Mastery: Precision in every shot.",
                  style: const TextStyle(
                    fontFamily: "Custom",
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                _bulletText("Agility Drills: Mastering the 6-point footwork."),
                _bulletText("Game Intelligence: Reading opponent movements."),
                _bulletText(
                  "Physical Conditioning: Strength and explosive power.",
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                _trainingDetail?.learningImageUrl ?? "",
                height: 120,
                fit: BoxFit.cover,
                cacheWidth: _cacheWidth(context, factor: 0.35),
                cacheHeight: (120 * MediaQuery.devicePixelRatioOf(context))
                    .round(),
                gaplessPlayback: true,
                filterQuality: FilterQuality.medium,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 120,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.image, size: 40),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "• ",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontFamily: "Custom", fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _coach() {
    final coaches = _trainingDetail?.coaches ?? [];

    if (coaches.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('No coach information available'),
      );
    }

    final coach = coaches[0];

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              coach.coachImageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              cacheWidth: (100 * MediaQuery.devicePixelRatioOf(context))
                  .round(),
              cacheHeight: (100 * MediaQuery.devicePixelRatioOf(context))
                  .round(),
              gaplessPlayback: true,
              filterQuality: FilterQuality.medium,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.person, size: 40),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coach.instructorName,
                  style: const TextStyle(
                    fontFamily: "Custom",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  coach.biography,
                  style: const TextStyle(fontFamily: "Custom", fontSize: 12),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _offer() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Expanded(
            flex: 1,
            child: Text(
              "50% OFF",
              style: TextStyle(
                fontFamily: "Custom",
                fontSize: 28,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Early Bird Special",
                  style: TextStyle(
                    fontFamily: "Custom",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "50% discount on your first month's registration!",
                  style: TextStyle(fontFamily: "Custom", fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _enroll(int selectedIndex) {
    final levels = _trainingDetail?.levels ?? [];
    final selectedLevel = levels.isNotEmpty && selectedIndex < levels.length
        ? levels[selectedIndex]
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => enrollForm(
                trainingId: widget.trainingId,
                trainingTitle: _trainingDetail?.courseName,
                levelId: selectedLevel?.id,
                levelName: selectedLevel?.titleLevel,
                price: selectedLevel?.price,
              ),
            ),
          );
        },
        icon: const Icon(Icons.event),
        label: const Text(
          "Enroll Now",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Custom',
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _bottomBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: const Color.fromARGB(255, 13, 27, 42),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Ready to Master the Court?",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 67, 251, 74),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            "Contact us to book your free trial session.",
            style: TextStyle(
              fontFamily: "Custom",
              fontSize: 11,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.phone, size: 14, color: Colors.white70),
              const SizedBox(width: 4),
              const Text(
                "09 123 456 789",
                style: TextStyle(
                  fontFamily: "Custom",
                  fontSize: 11,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
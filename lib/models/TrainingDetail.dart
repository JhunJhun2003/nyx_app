class TrainingDetail {
  final int id;
  final String categoryCardImageUrl;
  final String learningImageUrl;
  final String mainTitle;
  final String title;
  final String aboutTitle;
  final String details;
  final String learningDescription;
  final String courseName;
  final List<Level> levels;
  final List<Coach> coaches;
  final List<Schedule> schedules;

  TrainingDetail({
    required this.id,
    required this.categoryCardImageUrl,
    required this.learningImageUrl,
    required this.mainTitle,
    required this.title,
    required this.aboutTitle,
    required this.details,
    required this.learningDescription,
    required this.courseName,
    required this.levels,
    required this.coaches,
    required this.schedules,
  });

  factory TrainingDetail.fromJson(Map<String, dynamic> json) {
    return TrainingDetail(
      id: json['id'] as int,
      categoryCardImageUrl: json['category_card_image_url']?.toString() ?? '',
      learningImageUrl: json['learning_image_url']?.toString() ?? '',
      mainTitle: json['main_title']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      aboutTitle: json['about_title']?.toString() ?? '',
      details: json['details']?.toString() ?? '',
      learningDescription: json['learning_description']?.toString() ?? '',
      courseName: json['course_name']?.toString() ?? '',
      levels: (json['levels'] as List?)?.map((e) => Level.fromJson(e)).toList() ?? [],
      coaches: (json['coaches'] as List?)?.map((e) => Coach.fromJson(e)).toList() ?? [],
      schedules: (json['schedules'] as List?)?.map((e) => Schedule.fromJson(e)).toList() ?? [],
    );
  }
}

class Level {
  final int id;
  final int price;
  final String titleLevel;

  Level({
    required this.id,
    required this.price,
    required this.titleLevel,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'] as int,
      price: json['price'] as int,
      titleLevel: json['title_level']?.toString() ?? '',
    );
  }
}

class Coach {
  final int id;
  final String biography;
  final String coachImageUrl;
  final String instructorName;

  Coach({
    required this.id,
    required this.biography,
    required this.coachImageUrl,
    required this.instructorName,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['id'] as int,
      biography: json['biography']?.toString() ?? '',
      coachImageUrl: json['coach_image_url']?.toString() ?? '',
      instructorName: json['instructor_name']?.toString() ?? '',
    );
  }
}

class Schedule {
  final String day;
  final int dayId;
  final int slotId;
  final String endTime;
  final String startTime;
  final int trainingLevelId;

  Schedule({
    required this.day,
    required this.dayId,
    required this.slotId,
    required this.endTime,
    required this.startTime,
    required this.trainingLevelId,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      day: json['day']?.toString() ?? '',
      dayId: json['day_id'] as int,
      slotId: json['slot_id'] as int,
      endTime: json['end_time']?.toString() ?? '',
      startTime: json['start_time']?.toString() ?? '',
      trainingLevelId: json['training_level_id'] as int,
    );
  }
}
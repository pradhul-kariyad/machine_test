class StreakModel {
  final int? currentDay;
  final int? totalDays;
  final List<StreakDay>? days;

  StreakModel({
    this.currentDay,
    this.totalDays,
    this.days,
  });

  factory StreakModel.fromJson(Map<String, dynamic> json) {
    return StreakModel(
      currentDay: json['current_day'],
      totalDays: json['total_days'],
      days: json['days'] != null
          ? (json['days'] as List).map((e) => StreakDay.fromJson(e)).toList()
          : [],
    );
  }
}

class StreakDay {
  final int? day;
  final bool? isCompleted;
  final bool? isCurrent;
  final String? module;

  StreakDay({
    this.day,
    this.isCompleted,
    this.isCurrent,
    this.module,
  });

  factory StreakDay.fromJson(Map<String, dynamic> json) {
    return StreakDay(
      day: json['day_number'],
      isCompleted: json['is_completed'] ?? false,
      isCurrent: json['is_current'] ?? false,

      module: json['topic'] != null &&
              json['topic']['modules'] != null &&
              (json['topic']['modules'] as List).isNotEmpty
          ? json['topic']['modules'][0]['name']
          : null,
    );
  }
}

class ApiConstants {
  static const String baseUrl = 'https://trogon.info/task/api/';
  static const String home = 'home.php';
  static const String videoDetails = 'video_details.php';
  static const String streak = 'streak.php';

  static String get homeUrl => '$baseUrl$home';
  static String get videoDetailsUrl => '$baseUrl$videoDetails';
  static String get streakUrl => '$baseUrl$streak';
}

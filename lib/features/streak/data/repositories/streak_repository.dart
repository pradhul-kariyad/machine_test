import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/streak_model.dart';

class StreakRepository {
  Future<StreakModel> getStreakData() async {
    try {
      final response = await ApiClient.get(ApiConstants.streakUrl);
      return StreakModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch streak data: $e');
    }
  }
}

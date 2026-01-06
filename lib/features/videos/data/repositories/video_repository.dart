import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/video_model.dart';

class VideoRepository {
  Future<VideoModel> getVideoData() async {
    try {
      final response = await ApiClient.get(ApiConstants.videoDetailsUrl);
      return VideoModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch video data: $e');
    }
  }
}

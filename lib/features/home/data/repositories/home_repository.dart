import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/home_model.dart';

class HomeRepository {
  Future<HomeModel> getHomeData() async {
    try {
      final response = await ApiClient.get(ApiConstants.homeUrl);
      return HomeModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch home data: $e');
    }
  }
}
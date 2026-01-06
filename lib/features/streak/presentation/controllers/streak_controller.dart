import 'dart:developer';
import 'package:get/get.dart';
import '../../data/models/streak_model.dart';
import '../../data/repositories/streak_repository.dart';

class StreakController extends GetxController {
  final StreakRepository _repository = Get.find();

  final streakData = Rxn<StreakModel>();
  final isLoading = false.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStreakData();
  }

  Future<void> fetchStreakData() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final data = await _repository.getStreakData();
      streakData.value = data;
    } catch (e) {
      hasError.value = true;
      log('Error fetching streak data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void retry() => fetchStreakData();

  void onDayTap(StreakDay day) {
    Get.snackbar(
      'Day ${day.day}',
      day.isCompleted == true
          ? 'Great job on completing this day!'
          : 'Keep going to complete this day!',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

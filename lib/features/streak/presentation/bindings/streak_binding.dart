import 'package:get/get.dart';
import '../../data/repositories/streak_repository.dart';
import '../controllers/streak_controller.dart';

class StreakBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreakRepository>(() => StreakRepository());
    Get.lazyPut<StreakController>(() => StreakController());
  }
}
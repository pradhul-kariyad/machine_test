import 'package:get/get.dart';
import '../../data/repositories/video_repository.dart';
import '../controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoRepository>(() => VideoRepository());
    Get.lazyPut<VideoController>(() => VideoController());
  }
}
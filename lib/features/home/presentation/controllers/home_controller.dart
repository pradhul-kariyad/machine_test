import 'package:get/get.dart';
import '../../data/models/home_model.dart';
import '../../data/repositories/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository = Get.find();

  final homeData = Rxn<HomeModel>();
  final isLoading = false.obs;
  final hasError = false.obs;

  final selectedCategoryIndex = 0.obs;
  final currentNavIndex = 0.obs;

  @override
  void onInit() {
    fetchHomeData();
    super.onInit();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading(true);
      hasError(false);
      homeData.value = await repository.getHomeData();
    } catch (_) {
      hasError(true);
    } finally {
      isLoading(false);
    }
  }

  void retry() => fetchHomeData();

  void changeCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  List<PopularCourses> get categories => homeData.value?.popularCourses ?? [];

  List<Courses> get selectedCourses {
    if (categories.isEmpty) return [];
    return categories[selectedCategoryIndex.value].courses ?? [];
  }

  void onNavTap(int index) {
    currentNavIndex.value = index;
  }
}

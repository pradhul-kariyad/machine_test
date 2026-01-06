import 'package:get/get.dart';
import '../../features/home/presentation/bindings/home_binding.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/bindings/onboarding_binding.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/streak/presentation/bindings/streak_binding.dart';
import '../../features/streak/presentation/pages/streak_page.dart';
import '../../features/videos/presentation/bindings/video_binding.dart';
import '../../features/videos/presentation/pages/videos_page.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingPage(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.videos,
      page: () => const VideosPage(),
      binding: VideoBinding(),
    ),
    GetPage(
      name: AppRoutes.streak,
      page: () => const StreakPage(),
      binding: StreakBinding(),
    ),
  ];
}

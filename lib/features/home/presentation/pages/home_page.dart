import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/constants/image_path.dart';
import 'package:machine_test/core/theme/app_colors.dart';
import 'package:machine_test/features/streak/presentation/bindings/streak_binding.dart';
import 'package:machine_test/features/streak/presentation/pages/streak_page.dart';
import '../controllers/home_controller.dart';
import '../widgets/greeting_header.dart';
import '../widgets/hero_banner_slider.dart';
import '../widgets/section_title.dart';
import '../widgets/active_course_card.dart';
import '../widgets/category_chips.dart';
import '../widgets/popular_courses_section.dart';
import '../widgets/live_class_card.dart';
import '../widgets/community_card.dart';
import '../widgets/testimonials_section.dart';
import '../widgets/contact_section.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.homeData.value;

        return RefreshIndicator(
          onRefresh: controller.fetchHomeData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => const StreakPage(),
                          binding: StreakBinding(),
                        );
                      },
                      child: GreetingHeader(
                        greeting: data?.user?.greeting ?? 'Good Morning, Arjun',
                        streakDay: data?.user?.streak?.days ?? 7,
                        onStreakTap: () {
                          Get.to(
                            () => const StreakPage(),
                            binding: StreakBinding(),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.w, top: 110.h),
                      child: HeroBannerSlider(banners: data?.heroBanners ?? []),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        'Active Courses',
                      ),
                      ActiveCourseCard(
                        title: "KTET – Language Teachers",
                        completedTests: 70,
                        totalTests: 100,
                        progress: 35,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SectionTitle('Popular Courses'),
                          Text(
                            'View all',
                            style: GoogleFonts.dmSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                      CategoryChips(
                          categories: controller.categories,
                          selectedIndex: controller.selectedCategoryIndex.value,
                          onTap: controller.changeCategory),
                      SizedBox(height: 12.h),
                      PopularCoursesSection(
                          courses: controller.selectedCourses),
                      SizedBox(height: 20.h),
                      LiveSessionCard(liveSession: data?.liveSession),
                      SizedBox(height: 20.h),
                      CommunityCard(community: data?.community),
                      SizedBox(height: 20.h),
                      const SectionTitle('What Learners Are Saying'),
                      TestimonialsSection(
                        testimonials: data?.testimonials ?? [],
                      ),
                      SizedBox(height: 20.h),
                      const ContactSection(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final index = controller.currentNavIndex.value;
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: index,
            onTap: controller.onNavTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(ImagesRes.icon1),
                  color: index == 0 ? AppColors.primary : Colors.grey,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(ImagesRes.icon2),
                  color: index == 1 ? AppColors.primary : Colors.grey,
                ),
                label: "Courses",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(ImagesRes.icon3),
                  color: index == 2 ? AppColors.primary : Colors.grey,
                ),
                label: "Schedule",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(ImagesRes.icon4),
                  color: index == 3 ? AppColors.primary : Colors.grey,
                ),
                label: "Profile",
              ),
            ],
          ),
        );
      }),
    );
  }
}

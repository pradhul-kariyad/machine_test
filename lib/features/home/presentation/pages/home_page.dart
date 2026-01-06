import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
                GreetingHeader(
                  greeting: data?.user?.greeting ?? 'Good Morning, Arjun',
                  streakDay: data?.user?.streak?.days ?? 7,
                  onStreakTap: () {
                    Get.to(
                      () => const StreakPage(),
                      binding: StreakBinding(),
                    );
                  },
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: HeroBannerSlider(banners: data?.heroBanners ?? []),
                ),

                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle('Active Courses'),
                      ActiveCourseCard(course: data?.activeCourse),

                      SizedBox(height: 20.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          SectionTitle('Popular Courses'),
                          Text(
                            'View all',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),

                      CategoryChips(
                        categories: controller.categories,
                        selectedIndex: controller.selectedCategoryIndex.value,
                        onTap: controller.changeCategory,
                      ),

                      SizedBox(height: 12.h),

                      PopularCoursesSection(
                        courses: controller.selectedCourses,
                      ),

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

                      SizedBox(height: 80.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),

      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            onTap: controller.onNavTap,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_today), label: "Schedule"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}

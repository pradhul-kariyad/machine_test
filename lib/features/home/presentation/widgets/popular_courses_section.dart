import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/theme/app_colors.dart';
import '../../data/models/home_model.dart';
import '../../../videos/presentation/pages/videos_page.dart';
import '../../../videos/presentation/bindings/video_binding.dart';

class PopularCoursesSection extends StatelessWidget {
  final List<Courses> courses;

  const PopularCoursesSection({
    super.key,
    required this.courses,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 2.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: .78,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: courses.length,
      itemBuilder: (_, i) {
        final c = courses[i];

        return GestureDetector(
          onTap: () {
            Get.to(
              () => const VideosPage(),
              binding: VideoBinding(),
              arguments: {
                "course_id": c.id,
              },
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    c.image ?? '',
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        c.title ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.dmSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        side: BorderSide.none,
                        backgroundColor: AppColors.primary),
                    onPressed: () {
                      Get.to(
                        () => const VideosPage(),
                        binding: VideoBinding(),
                        arguments: {
                          "course_id": c.id,
                        },
                      );
                    },
                    child: Text(
                      "Explore More",
                      style: TextStyle(color: AppColors.cardBg),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.h,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

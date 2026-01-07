import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/constants/image_path.dart';
import 'package:machine_test/core/theme/app_colors.dart';

class ActiveCourseCard extends StatelessWidget {
  final String title;
  final int completedTests;
  final int totalTests;
  final double progress;

  const ActiveCourseCard({
    super.key,
    required this.title,
    required this.completedTests,
    required this.totalTests,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xff3B79FF),
            Color(0xff1F54E5),
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 78.w,
            height: 78.w,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 36.w,
                  backgroundColor: Colors.white.withOpacity(.18),
                ),
                SizedBox(
                  width: 78.w,
                  height: 78.w,
                  child: CircularProgressIndicator(
                    value: progress / 60,
                    strokeWidth: 8.w,
                    strokeCap: StrokeCap.round,
                    backgroundColor: Colors.white,
                    valueColor: const AlwaysStoppedAnimation(
                      Color(0xffFFD54F),
                    ),
                  ),
                ),
                Text(
                  "${progress.toInt()}%",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffFFD54F),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.dmSans(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(ImagesRes.img6),
                        radius: 8.r,
                        backgroundColor: Color(0xff3B79FF),
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "$completedTests/$totalTests Tests",
                        style: TextStyle(color: Colors.white, fontSize: 12.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: Text(
                                "Continue  >>>",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Shift Course",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

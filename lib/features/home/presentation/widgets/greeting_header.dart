import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/constants/image_path.dart';
import 'package:machine_test/core/theme/app_colors.dart';

class GreetingHeader extends StatelessWidget {
  final String greeting;
  final int streakDay;
  final VoidCallback onStreakTap;

  const GreetingHeader({
    super.key,
    required this.greeting,
    required this.streakDay,
    required this.onStreakTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148.h,
      padding: EdgeInsets.fromLTRB(16.w, 50.h, 16.w, 24.h),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(ImagesRes.img4), fit: BoxFit.cover),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60.r),
          bottomRight: Radius.circular(60.r),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Text(
                  greeting,
                  style: GoogleFonts.dmSans(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.cardBg,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h, left: 30.w),
            child: InkWell(
              onTap: onStreakTap,
              borderRadius: BorderRadius.circular(20.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Text(
                      'Day $streakDay',
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '🔥',
                      style: TextStyle(fontSize: 13.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 30.h),
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(2.r),
                child: Image.asset(
                  ImagesRes.img5,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

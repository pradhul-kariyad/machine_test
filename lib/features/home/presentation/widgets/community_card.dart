import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/constants/image_path.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/home_model.dart';

class CommunityCard extends StatelessWidget {
  final Community? community;

  const CommunityCard({super.key, this.community});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(ImagesRes.img7),
                radius: 20.r,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      community?.name ?? 'General Community',
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '${community?.activeMembers ?? 0} active members',
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        color: AppColors.textLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            community?.description ??
                'Connect with learners across all courses. Share experiences, ask questions, and grow together in your learning journey.',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textLight,
            ),
          ),
          SizedBox(height: 12.h),
          InkWell(
            onTap: () {},
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: const Color(0xffF0F7FF),
              ),
              child: Center(
                child: Text(
                  'Join Discussion',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              SizedBox(
                width: 70.w,
                height: 28.h,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: CircleAvatar(
                        radius: 13.r,
                        backgroundImage: AssetImage(ImagesRes.img1),
                      ),
                    ),
                    Positioned(
                      left: 20.w,
                      child: CircleAvatar(
                        radius: 13.r,
                        backgroundImage: AssetImage(ImagesRes.img2),
                      ),
                    ),
                    Positioned(
                      left: 40.w,
                      child: CircleAvatar(
                        radius: 13.r,
                        backgroundImage: AssetImage(ImagesRes.img1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '12 recent posts',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              Text(
                'Active now',
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

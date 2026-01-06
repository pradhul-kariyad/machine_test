import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: AppColors.streakBg,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child:
                    Icon(Icons.people, color: AppColors.primary, size: 28.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(community?.name ?? 'Wellness Community',
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textDark)),
                    Text(
                      '${community?.activeMembers ?? 0} members',
                      style: TextStyle(
                          fontSize: 12.sp, color: AppColors.textLight),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            community?.description ??
                'Join our community to share experiences, tips, and support each other on the wellness journey.',
            style: TextStyle(
                fontSize: 14.sp, color: AppColors.textLight, height: 1.5),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.streakBg
              ),
              onPressed: () {},
              child:  Text('Join Discussion',style: TextStyle(color: AppColors.primary),),
            ),
          ),
        ],
      ),
    );
  }
}

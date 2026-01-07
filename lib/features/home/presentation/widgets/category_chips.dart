import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/theme/app_colors.dart';
import '../../data/models/home_model.dart';

class CategoryChips extends StatelessWidget {
  final List<PopularCourses> categories;
  final int selectedIndex;
  final Function(int) onTap;

  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 8.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12.h,
        crossAxisSpacing: 12.w,
        childAspectRatio: 2.8,
      ),
      itemBuilder: (_, index) {
        final isSelected = index == selectedIndex;

        return GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xff0FBCC7)
                  : const Color.fromARGB(255, 217, 241, 246),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              categories[index].name ?? '',
              style: GoogleFonts.dmSans(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.primary,
              ),
            ),
          ),
        );
      },
    );
  }
}

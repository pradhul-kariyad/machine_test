import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/home_model.dart';

class ActiveCourseCard extends StatelessWidget {
  final ActiveCourse? course;

  const ActiveCourseCard({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) return const SizedBox();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xff245ED8),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course!.title!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 12.h),
          LinearProgressIndicator(
            value: (course!.progress ?? 0) / 100,
            backgroundColor: Colors.white24,
            valueColor: const AlwaysStoppedAnimation(Colors.white),
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("${course!.testsCompleted}/${course!.totalTests} Tests",
                  style: const TextStyle(color: Colors.white70)),
              Text("${course!.progress}%",
                  style: const TextStyle(color: Colors.white))
            ],
          )
        ],
      ),
    );
  }
}

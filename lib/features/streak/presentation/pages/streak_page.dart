// ignore_for_file: unused_import

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/streak_model.dart';
import '../controllers/streak_controller.dart';

class StreakPage extends GetView<StreakController> {
  const StreakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.streakBg,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64.sp, color: Colors.red),
                SizedBox(height: 16.h),
                Text('Failed to load streak',
                    style: TextStyle(fontSize: 16.sp)),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final days = controller.streakData.value?.days ?? [];

        return Stack(
          children: [
            _star(top: 60, left: 40),
            _star(top: 150, right: 50),
            _star(bottom: 120, left: 30),
            _star(bottom: 200, right: 40),

            Positioned.fill(
              child: CustomPaint(
                painter: _DottedPathPainter(count: days.length),
              ),
            ),

            SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Column(
                children: List.generate(days.length, (index) {
                  final day = days[index];
                  final isLeft = index % 2 == 0;

                  return SizedBox(
                    height: 120.h,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          left: isLeft ? 40.w : null,
                          right: isLeft ? null : 40.w,
                          child: GestureDetector(
                            onTap: () => controller.onDayTap(day),
                            child: _buildStreakCircle(day),
                          ),
                        ),

                        if (day.isCurrent == true && day.module != null)
                          Positioned(
                            left: isLeft ? null : 80.w,
                            right: isLeft ? 80.w : null,
                            child: _buildTopicBubble(day.module!),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _star({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top?.h,
      bottom: bottom?.h,
      left: left?.w,
      right: right?.w,
      child: Icon(
        Icons.star,
        size: 26.sp,
        color: Colors.white.withOpacity(0.25),
      ),
    );
  }

  Widget _buildStreakCircle(StreakDay day) {
    final bool completed = day.isCompleted == true;
    final bool current = day.isCurrent == true;

    return Container(
      width: 76.w,
      height: 76.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: completed
            ? AppColors.primary
            : current
                ? AppColors.primary.withOpacity(0.15)
                : Colors.white,
        border: Border.all(color: AppColors.primary, width: 3),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Day',
            style: TextStyle(
              fontSize: 11.sp,
              color: completed ? Colors.white : AppColors.primary,
            ),
          ),
          Text(
            '${day.day}',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: completed ? Colors.white : AppColors.primary,
            ),
          ),
          if (completed) Icon(Icons.check, color: Colors.white, size: 16.sp),
        ],
      ),
    );
  }

  Widget _buildTopicBubble(String title) {
    return Container(
      width: 160.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Today's Topic",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 13.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DottedPathPainter extends CustomPainter {
  final int count;

  _DottedPathPainter({required this.count});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.6)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    double y = 80;

    path.moveTo(size.width / 2, y);

    for (int i = 0; i < count; i++) {
      y += 100;
      final x = i.isEven ? size.width * 0.25 : size.width * 0.75;
      path.quadraticBezierTo(
        size.width / 2,
        y - 50,
        x,
        y,
      );
    }

    _drawDottedPath(canvas, path, paint);
  }

  void _drawDottedPath(Canvas canvas, Path path, Paint paint) {
    const dashWidth = 6.0;
    const dashSpace = 6.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final extract = metric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extract, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

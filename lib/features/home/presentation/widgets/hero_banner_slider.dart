import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/home_model.dart';

class HeroBannerSlider extends StatelessWidget {
  final List<HeroBanners> banners;
  const HeroBannerSlider({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    if (banners.isEmpty) return const SizedBox();

    return SizedBox(
      height: 160.h,
      child: PageView.builder(
        itemCount: banners.length,
        itemBuilder: (_, index) {
          final banner = banners[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              image: DecorationImage(
                image: NetworkImage(banner.image ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.all(16.w),
            child: Text(
              banner.title ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }
}

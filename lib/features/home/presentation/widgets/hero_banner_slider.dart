import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/home_model.dart';

class HeroBannerSlider extends StatefulWidget {
  final List<HeroBanners> banners;

  const HeroBannerSlider({
    super.key,
    required this.banners,
  });

  @override
  State<HeroBannerSlider> createState() => _HeroBannerSliderState();
}

class _HeroBannerSliderState extends State<HeroBannerSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(
      const Duration(seconds: 3),
      (timer) {
        if (!mounted || widget.banners.isEmpty) return;

        _currentIndex = (_currentIndex + 1) % widget.banners.length;

        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox();

    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.banners.length,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            itemBuilder: (_, index) {
              final banner = widget.banners[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  image: DecorationImage(
                    image: NetworkImage(banner.image ?? ''),
                    fit: BoxFit.contain,
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
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: _currentIndex == index ? 27.w : 8.w,
              height: 6.h,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? const Color(0xFFFDB918)
                    : const Color(0xFFEBEBEB),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

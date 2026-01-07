import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test/core/theme/app_colors.dart';
import '../../data/models/home_model.dart';

class TestimonialsSection extends StatefulWidget {
  final List<Testimonials> testimonials;

  const TestimonialsSection({
    super.key,
    required this.testimonials,
  });

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController();
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.testimonials.isEmpty) return SizedBox();

    return Column(
      children: [
        SizedBox(
          height: 168.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.testimonials.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (_, i) {
              final t = widget.testimonials[i];

              return Container(
                // margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.r),
                          topRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18.r,
                            backgroundImage: NetworkImage(
                              t.learner?.avatar ??
                                  'https://via.placeholder.com/150',
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                t.learner?.name ?? "Anonymous",
                                style: GoogleFonts.poppins(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  ...List.generate(
                                      5,
                                      (i) => const Icon(Icons.star,
                                          size: 14, color: Colors.amber)),
                                  SizedBox(width: 5),
                                  Text(
                                    "4.5",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Text(
                          t.review ?? '',
                          style: GoogleFonts.poppins(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff959292),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),

        SizedBox(height: 10.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.testimonials.length,
            (i) => AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: i == _index ? 22.w : 8.w,
              height: 6.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                color: i == _index ? AppColors.primary : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

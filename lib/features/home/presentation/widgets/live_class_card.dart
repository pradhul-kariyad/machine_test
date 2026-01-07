import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../data/models/home_model.dart';

class LiveSessionCard extends StatelessWidget {
  final LiveSession? liveSession;
  const LiveSessionCard({super.key, this.liveSession});

  @override
  Widget build(BuildContext context) {
    if (liveSession == null) return const SizedBox();

    final session = liveSession!;
    final sessionNo = session.sessionDetails?.sessionNumber ?? 0;
    final date = session.sessionDetails?.date ?? '';
    final time = session.sessionDetails?.time ?? '';
    final instructor = session.instructor?.name ?? '';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFF6D9),
            Color(0xFFFFE3A8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (session.isLive == true)
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF32C27C),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          "Live",
                          style: GoogleFonts.poppins(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                SizedBox(height: 10.h),
                Text(
                  session.title ?? "",
                  style: GoogleFonts.dmSans(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  instructor,
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Session $sessionNo • $date $time",
                  style: GoogleFonts.dmSans(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color.fromARGB(255, 232, 192, 100)),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {},
            child: Text(
              "Join Now",
              style: GoogleFonts.dmSans(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 232, 192, 100),
              ),
            ),
          )
        ],
      ),
    );
  }
}

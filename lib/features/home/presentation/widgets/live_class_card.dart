import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/models/home_model.dart';

class LiveSessionCard extends StatelessWidget {
  final LiveSession? liveSession;
  const LiveSessionCard({super.key, this.liveSession});

  @override
  Widget build(BuildContext context) {
    if (liveSession == null) return const SizedBox();

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.live_tv, color: Colors.white),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  liveSession!.isLive == true ? 'LIVE' : 'UPCOMING',
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  liveSession!.title ?? '',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  liveSession!.sessionDetails?.time ?? '',
                  style: const TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

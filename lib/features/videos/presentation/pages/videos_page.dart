import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/theme/app_colors.dart';
import '../controllers/video_controller.dart';

class VideosPage extends GetView<VideoController> {
  const VideosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                Text('Failed to load videos',
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

        final videoModel = controller.videoData.value;
        final section = videoModel?.videos;
        final videos = section?.videos ?? [];

        if (videos.isEmpty) {
          return Center(
            child:
                Text('No videos available', style: TextStyle(fontSize: 16.sp)),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildVideoPlayer(),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          final currentId =
                              controller.currentPlayingVideoId.value;
                          final currentVideo =
                              videos.firstWhereOrNull((v) => v.id == currentId);
                          return Text(
                            currentVideo?.title ?? 'Video 1',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          );
                        }),
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.download_outlined,
                            size: 20.sp,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),

                    Obx(() {
                      final currentId = controller.currentPlayingVideoId.value;
                      final currentVideo =
                          videos.firstWhereOrNull((v) => v.id == currentId);
                      return Text(
                        currentVideo?.description ??
                            'Understanding the Basic of Meditation',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                        ),
                      );
                    }),
                    SizedBox(height: 20.h),

                    Text(
                      section?.title ?? 'Meditation Journey',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    ...List.generate(videos.length, (index) {
                      final video = videos[index];
                      return _buildVideoListItem(video, index);
                    }),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildVideoPlayer() {
    return Container(
      width: double.infinity,
      height: 220.h,
      color: Colors.black,
      child: Obx(() {
        final player = controller.videoPlayerController.value;

        if (player == null || !player.value.isInitialized) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 16.h),
                Text(
                  'Loading video...',
                  style: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: player.value.aspectRatio,
                child: VideoPlayer(player),
              ),
            ),

            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  controller.togglePlayPause();
                },
                child: Container(
                  color: Colors.transparent,
                  child: Center(
                    child: Obx(() {
                      final isPlaying = controller.isVideoPlaying.value;
                      return AnimatedOpacity(
                        opacity: isPlaying ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.play_arrow,
                            size: 48.sp,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() {
                      final position = controller.videoPosition.value;
                      final duration = controller.videoDuration.value;
                      final progress = duration.inMilliseconds > 0
                          ? position.inMilliseconds / duration.inMilliseconds
                          : 0.0;

                      return SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 3.h,
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 6.r),
                          overlayShape:
                              RoundSliderOverlayShape(overlayRadius: 12.r),
                          activeTrackColor: Colors.white,
                          inactiveTrackColor: Colors.white.withOpacity(0.3),
                          thumbColor: Colors.white,
                          overlayColor: Colors.white.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: progress.clamp(0.0, 1.0),
                          onChanged: (value) {
                            final newPosition = duration * value;
                            controller.seekTo(newPosition);
                          },
                        ),
                      );
                    }),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() {
                            final position = controller.videoPosition.value;
                            return Text(
                              _formatDuration(position),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                          Obx(() {
                            final duration = controller.videoDuration.value;
                            return Text(
                              _formatDuration(duration),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildVideoListItem(dynamic video, int index) {
    return Obx(() {
      final isCompleted = video.isCompleted;
      final isLocked = video.isLocked;
      final isCurrentlyPlaying =
          controller.currentPlayingVideoId.value == video.id;

      return Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: isCurrentlyPlaying
              ? AppColors.primary.withOpacity(0.08)
              : Colors.grey[50],
          borderRadius: BorderRadius.circular(12.r),
          border: isCurrentlyPlaying
              ? Border.all(color: AppColors.primary, width: 2)
              : Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          leading: Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: isCompleted
                  ? AppColors.success
                  : isLocked
                      ? Colors.grey[400]
                      : AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted
                  ? Icons.check
                  : isLocked
                      ? Icons.lock_outline
                      : Icons.play_arrow,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          title: Text(
            video.title ?? 'Video ${index + 1}',
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: isLocked ? Colors.grey[600] : Colors.black87,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              video.description ?? 'Understanding the Basic of Meditation',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: isLocked ? Colors.grey[400] : Colors.black54,
            size: 24.sp,
          ),
          onTap: () => controller.onVideoTap(video),
        ),
      );
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

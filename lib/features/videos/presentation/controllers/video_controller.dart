import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/video_model.dart';
import '../../data/repositories/video_repository.dart';

class VideoController extends GetxController {
  final VideoRepository _repository = Get.find();

  final videoData = Rxn<VideoModel>();
  final isLoading = false.obs;
  final hasError = false.obs;
  final videoPlayerController = Rxn<VideoPlayerController>();
  final currentPlayingVideoId = Rxn<int>();
  final isVideoPlaying = false.obs;
  final videoPosition = Duration.zero.obs;
  final videoDuration = Duration.zero.obs;

  Timer? _progressTimer;

  @override
  void onInit() {
    super.onInit();
    fetchVideoData();
  }

  Future<void> fetchVideoData() async {
    try {
      isLoading.value = true;
      hasError.value = false;

      final data = await _repository.getVideoData();
      videoData.value = data;

      final firstVideo = data.videos?.videos.first;
      if (firstVideo != null && firstVideo.videoUrl != null) {
        await initializeVideo(firstVideo);
      }
    } catch (e) {
      hasError.value = true;
      log('Error fetching video data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initializeVideo(VideoItem video) async {
    try {
      _progressTimer?.cancel();
      await videoPlayerController.value?.dispose();
      videoPlayerController.value = null;
      isVideoPlaying.value = false;
      videoPosition.value = Duration.zero;
      videoDuration.value = Duration.zero;

      if (video.videoUrl == null || video.videoUrl!.isEmpty) {
        Get.snackbar('Error', 'Video URL not available');
        return;
      }

      String videoUrl = video.videoUrl!;

      log('Attempting to load video: $videoUrl');

      final uri = Uri.parse(videoUrl);

      final controller = VideoPlayerController.networkUrl(
        uri,
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
          allowBackgroundPlayback: false,
        ),
      );

      videoPlayerController.value = controller;
      currentPlayingVideoId.value = video.id;

      controller.addListener(() {
        isVideoPlaying.value = controller.value.isPlaying;

        if (controller.value.hasError) {
          log('Video player error: ${controller.value.errorDescription}');
          Get.snackbar(
            'Playback Error',
            'Failed to load video. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      });

      await controller.initialize().timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Video initialization timeout');
        },
      );

      videoDuration.value = controller.value.duration;

      _startProgressTracking();

      await controller.play();
      isVideoPlaying.value = true;

      log('Video initialized successfully');
    } catch (e) {
      log('Error initializing video: $e');
      await videoPlayerController.value?.dispose();
      videoPlayerController.value = null;
      isVideoPlaying.value = false;

      Get.snackbar(
        'Error',
        'Failed to load video: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _startProgressTracking() {
    _progressTimer?.cancel();
    _progressTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      final player = videoPlayerController.value;
      if (player != null && player.value.isInitialized) {
        videoPosition.value = player.value.position;
        videoDuration.value = player.value.duration;
      }
    });
  }

  void togglePlayPause() {
    final player = videoPlayerController.value;
    if (player == null) return;

    if (player.value.isPlaying) {
      player.pause();
      isVideoPlaying.value = false;
    } else {
      player.play();
      isVideoPlaying.value = true;
    }
  }

  void seekTo(Duration position) {
    final player = videoPlayerController.value;
    if (player == null) return;

    player.seekTo(position);
    videoPosition.value = position;
  }

  void onVideoTap(VideoItem video) async {
    if (video.isLocked) {
      Get.snackbar(
        'Locked',
        'Complete previous videos to unlock this one',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (video.videoUrl == null || video.videoUrl!.isEmpty) {
      Get.snackbar(
        'Error',
        'Video URL not available',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (currentPlayingVideoId.value == video.id) {
      togglePlayPause();
      return;
    }

    await initializeVideo(video);
  }

  void retry() {
    fetchVideoData();
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    videoPlayerController.value?.dispose();
    super.onClose();
  }
}

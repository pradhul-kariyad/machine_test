class VideoModel {
  final VideoSection? videos;

  VideoModel({this.videos});

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      videos:
          json['videos'] != null ? VideoSection.fromJson(json['videos']) : null,
    );
  }
}

class VideoSection {
  final String? title;
  final List<VideoItem> videos;

  VideoSection({
    this.title,
    required this.videos,
  });

  factory VideoSection.fromJson(Map<String, dynamic> json) {
    return VideoSection(
      title: json['title']?.toString(),
      videos: (json['videos'] as List? ?? [])
          .map((e) => VideoItem.fromJson(e))
          .toList(),
    );
  }
}

class VideoItem {
  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final String? icon;
  final String? videoUrl;
  final bool hasPlayButton;

  VideoItem({
    this.id,
    this.title,
    this.description,
    this.status,
    this.icon,
    this.videoUrl,
    required this.hasPlayButton,
  });

  factory VideoItem.fromJson(Map<String, dynamic> json) {
    return VideoItem(
      id: int.tryParse(json['id']?.toString() ?? ''),
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      status: json['status']?.toString(),
      icon: json['icon']?.toString(),
      videoUrl: json['video_url']?.toString(),
      hasPlayButton: json['has_play_button'] == true ||
          json['has_play_button'] == 1 ||
          json['has_play_button'] == '1',
    );
  }

  bool get isCompleted => status == 'completed';
  bool get isLocked => status == 'locked';
}

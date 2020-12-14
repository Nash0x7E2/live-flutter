import 'package:meta/meta.dart';

class Video {
  Video._({
    @required this.playbackId,
    @required this.assetId,
    @required this.duration,
    @required this.createdAt,
    @required this.playbackUrl,
    @required this.thumbnailUrl,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    final playback = List.from(map['playback_ids']).first['id'];
    return Video._(
      playbackId: playback,
      assetId: map['id'] as String,
      duration: map['duration'] != null
          ? Duration(seconds: (map['duration'] as double).toInt())
          : null,
      createdAt: DateTime.parse(map['created_at']),
      playbackUrl: "https://stream.mux.com/$playback.m3u8",
      thumbnailUrl:
          "https://image.mux.com/$playback/thumbnail.png?width=1920&height=1080&fit_mode=pad",
    );
  }

  @override
  String toString() {
    return 'Video{playbackUrl: $playbackUrl, playbackId: $playbackId, '
        'assetId: $assetId, duration: $duration, createdAt: $createdAt '
        'thumbnailUrl: $thumbnailUrl'
        '}';
  }

  final String playbackUrl;
  final String thumbnailUrl;
  final String playbackId;
  final String assetId;
  final Duration duration;
  final DateTime createdAt;
}

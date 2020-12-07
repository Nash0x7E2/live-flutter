import 'package:meta/meta.dart';

class Video {
  Video._({
    @required this.playbackId,
    @required this.assetId,
    @required this.duration,
    @required this.createdAt,
    @required this.playbackUrl,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    final playback = List.from(map['playback_ids']).first['id'];
    return Video._(
      playbackId: playback,
      assetId: map['id'] as String,
      duration: Duration(seconds: (map['duration'] as double).toInt()),
      createdAt: DateTime.parse(map['created_at']),
      playbackUrl: "https://stream.mux.com/$playback.m3u8",
    );
  }

  @override
  String toString() {
    return 'Video{playbackUrl: $playbackUrl, playbackId: $playbackId, '
        'assetId: $assetId, duration: $duration, createdAt: $createdAt}';
  }

  final String playbackUrl;
  final String playbackId;
  final String assetId;
  final Duration duration;
  final DateTime createdAt;
}

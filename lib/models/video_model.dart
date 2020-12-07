import 'package:meta/meta.dart';

class Video {
  Video._({
    @required this.playbackId,
    @required this.assetId,
    @required this.duration,
    @required this.createdAt,
  });

  factory Video.fromMap(Map<String, dynamic> map) {
    final playback = List.from(map['playback_ids']).first['id'];
    return Video._(
      playbackId: playback,
      assetId: map['id'] as String,
      duration: Duration(seconds: (map['duration'] as double).toInt()),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  final String playbackId;
  final String assetId;
  final Duration duration;
  final DateTime createdAt;
}

import 'package:hfs/backend/mux_backend.dart';
import 'package:hfs/backend/stream_backend.dart';
import 'package:hfs/config.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

@immutable
class Backend {
  final StreamBackEnd streamBackEnd;
  final MuxBackend muxBackend;

  const Backend._({
    @required this.streamBackEnd,
    @required this.muxBackend,
  });

  static Backend init() {
    final String muxApiKey = EnvironmentConfig.muxApi;
    final String streamApiKey = EnvironmentConfig.streamAPIKey;

    final httpClient = http.Client();

    final stream = StreamBackEnd(
      httpClient: httpClient,
      client: Client(
        streamApiKey,
        logLevel: Level.SEVERE,
      ),
    );
    final mux = MuxBackend(
      client: httpClient,
      muxApi: muxApiKey,
    );

    return Backend._(
      streamBackEnd: stream,
      muxBackend: mux,
    );
  }
}

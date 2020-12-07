import 'dart:convert' show base64;
import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:hfs/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class MuxBackend {
  MuxBackend({
    @required this.client,
    @required this.muxApiKey,
    @required this.muxSecret,
  }) : assert(client != null);

  final http.Client client;
  final String muxApiKey;
  final String muxSecret;
  final baseUrl = "https://stream.mux.com/";

  Future<List<Video>> fetchPastLivestreams() async {
    try {
      final token = baseEncodeToken(muxApiKey, muxSecret);
      final http.Response response = await http.get(
        "https://api.mux.com/video/v1/assets",
        headers: {"Authorization": "Basic $token"},
      );
      final data = jsonDecode(response.body)['data'] as List<dynamic>;
      return data.map((item) => Video.fromMap(item)).toList(growable: false);
    } catch (error) {
      log("fetchPastLivestreams: ${error.toString()}");
      throw Exception("Past livestream recordings are currently unavailable");
    }
  }

  Future<List<Video>> fetchLivestreams() async {
    try {} catch (error) {
      log(error.toString());
    }
  }

  String baseEncodeToken(String key, String secret) {
    return base64.encode("$key:$secret".codeUnits);
  }
}

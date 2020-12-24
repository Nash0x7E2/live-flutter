import 'dart:convert' show jsonDecode;
import 'dart:developer' show log;

import 'package:flutter/cupertino.dart';
import 'package:hfs/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class MuxBackend {
  MuxBackend({
    @required this.client,
    @required this.muxApi,
  }) : assert(client != null);

  final http.Client client;
  final String muxApi;

  Future<List<Video>> fetchPastLivestreams() async {
    try {
      final http.Response response = await http.get(
        "$muxApi/assets",
      );
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((item) => Video.fromMap(item)).toList(growable: false);
    } catch (error) {
      log("fetchPastLivestreams: ${error.toString()}");
      throw Exception("Past livestream recordings are currently unavailable");
    }
  }

  Future<List<Video>> fetchLivestreams() async {
    try {
      final http.Response response = await http.get(
        "$muxApi/live-streams",
      );
      final data = jsonDecode(response.body) as List<dynamic>;
      return data
          .where((data) => data["status"] == "active")
          .map((item) => Video.fromMap(item))
          .toList(growable: false);
    } catch (error) {
      log("fetchLivestreams: ${error.toString()}");
      throw Exception("Live streams are currently unavailable");
    }
  }
}

import 'dart:convert';
import 'dart:developer' show log;

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

@immutable
class StreamBackEnd {
  StreamBackEnd({
    @required this.client,
    @required this.httpClient,
  }) : assert(client != null);

  final Client client;
  final http.Client httpClient;

  Future<String> getUserToken({@required String name}) async {
    assert(name != null);
    try {
      final http.Response response = await httpClient.post(
        "https://stream-token-api-elkxvkzduq-ue.a.run.app/token",
        body: {
          "name": name,
        },
      );
      return jsonDecode(response.body)['token'];
    } catch (error) {
      log("getUserToken: ${error.toString()}");
      throw Exception(
        "Stream SDK unable to generate token for $name",
      );
    }
  }

  Future<void> configureUser({
    @required String name,
    @required String id,
  }) async {
    try {
      final token = await getUserToken(name: name);
      await client.setUser(
        User(
          id: name,
          extraData: {
            "name": name,
            'image': 'https://getstream.io/random_png/?name=$name',
          },
        ),
        token,
      );
    } catch (exception) {
      log(exception.toString());
      throw Exception(
        "Stream SDK cannot set user with ID $id",
      );
    }
  }

  Future<Channel> configureChannel({@required final String url}) async {
    final id = _generateMd5(url);
    try {
      final channel = client.channel('livestream', id: id);
      channel.watch();
      return channel;
    } catch (exception) {
      log(exception.toString());
      throw Exception(
        "Stream SDK cannot create channel for ID $id",
      );
    }
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}

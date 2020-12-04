import 'dart:developer' show log;
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

@immutable
class StreamBackEnd {
  StreamBackEnd()
      : client = Client(
          'd5xak7ubhw6s',
          logLevel: Level.INFO,
        );

  final Client client;

  Future<void> configureUser({
    @required String name,
    @required String id,
    @required String token,
  }) async {
    try {
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
        "Stream SDK cannot set user with ID $id and token $token",
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

import 'dart:developer' show log;

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

  Future<void> configureChannel({@required final String id}) async {
    try {
      final channel = client.channel('messaging', id: id);
      channel.watch();
      return;
    } catch (exception) {
      log(exception.toString());
      throw Exception(
        "Stream SDK cannot create channel for ID $id",
      );
    }
  }
}

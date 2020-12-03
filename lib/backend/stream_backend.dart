import 'dart:developer' show log;

import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamBackEnd {
  StreamBackEnd() {
    client = Client(
      'd5xak7ubhw6s',
      logLevel: Level.INFO,
    );
  }

  Client client;
  Channel channel;

  Future<void> configureUser(String name) async {
    try {
      await client.setUser(
        User(
          id: "nash",
          extraData: {
            "name": "Nash",
            'image':
                'https://getstream.io/random_png/?id=white-mouse-4&amp;name=White+mouse',
          },
        ),
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibmFzaCJ9.9mJyRhgRAINMTKHEue-ZqYHlJ6M2EtWLcsWYkVHuSOc',
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<bool> configureChannel() async {
    try {
      channel = client.channel('messaging', id: 'godevs');
      channel.watch();
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}

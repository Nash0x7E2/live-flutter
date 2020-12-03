import 'package:flutter/material.dart';
import 'package:hfs/providers/backend_provider.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:yoyo_player/yoyo_player.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({
    Key key,
    @required this.streamUrl,
  }) : super(key: key);

  static Route<dynamic> route(String url) {
    return MaterialPageRoute<dynamic>(
      builder: (BuildContext context) {
        return PlayerPage(streamUrl: url);
      },
    );
  }

  final String streamUrl;

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  final url =
      "https://stream.mux.com/YjS00rorMikb7ZdXD9RZw02DJSy3VLRmTJFZsekemji00Y.m3u8";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Video",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: YoYoPlayer(
                aspectRatio: 16 / 9,
                url: url,
                videoStyle: VideoStyle(),
                videoLoadingStyle: VideoLoadingStyle(),
              ),
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder(
                future: BackendProvider.of(context).configureChannel(),
                builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return StreamChat(
                      client: BackendProvider.of(context).client,
                      child: StreamChannel(
                        channel: BackendProvider.of(context).channel,
                        child: ChannelPage(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ChannelPage extends StatelessWidget {
  const ChannelPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: MessageListView(),
        ),
        MessageInput(),
      ],
    );
  }
}

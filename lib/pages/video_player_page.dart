import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hfs/bloc/channel_cubit/channel_cubit.dart';
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
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

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
          style: GoogleFonts.inter(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: YoYoPlayer(
                aspectRatio: 16 / 9,
                url: widget.streamUrl ?? url,
                videoStyle: VideoStyle(),
                videoLoadingStyle: VideoLoadingStyle(),
              ),
            ),
            Expanded(
              flex: 4,
              child: BlocBuilder<ChannelCubit, CubitChannelState>(
                builder: (BuildContext context, state) {
                  if (state is DataChannelState && state.channel != null) {
                    return StreamChannel(
                      channel: state.channel,
                      child: ChannelPage(),
                    );
                  } else if (state is DataChannelState && state.isLoading) {
                    return Center(
                      child: SizedBox(
                        height: 100.0,
                        width: 100.0,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is DataChannelState && state.hasError) {
                    return Center(
                      child: Text("Oh no, we can't load comments right now :/"),
                    );
                  } else {
                    return const SizedBox();
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

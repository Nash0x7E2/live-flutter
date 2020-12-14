import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hfs/backend/backend.dart';
import 'package:hfs/bloc/archived_videos_cubit/archived_videos_cubit.dart';
import 'package:hfs/bloc/channel_cubit/channel_cubit.dart';
import 'package:hfs/bloc/livevideos_cubit/livestream_cubit.dart';
import 'package:hfs/bloc/user_cubit/stream_cubit.dart';
import 'package:hfs/pages/landing_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final Backend backend = Backend.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(HLSPOC(backend: backend));
}

class HLSPOC extends StatelessWidget {
  const HLSPOC({
    Key key,
    @required this.backend,
  })  : assert(backend != null),
        super(key: key);

  final Backend backend;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(backend: backend.streamBackEnd),
        ),
        BlocProvider(
          create: (context) => ChannelCubit(backend: backend.streamBackEnd),
        ),
        BlocProvider(
          create: (context) => ArchivedVideosCubit(
            muxBackend: backend.muxBackend,
          )..getArchivedVideos(),
        ),
        BlocProvider(
          create: (context) => LivestreamCubit(
            muxBackend: backend.muxBackend,
          )..loadStreams(),
        ),
      ],
      child: StreamChat(
        client: backend.streamBackEnd.client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
        ),
      ),
    );
  }
}

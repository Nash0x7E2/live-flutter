import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hfs/backend/stream_backend.dart';
import 'package:hfs/bloc/channel_cubit/cubit/channel_cubit.dart';
import 'package:hfs/bloc/user_cubit/stream_cubit.dart';
import 'package:hfs/pages/landing_page.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(HLSPOC());
}

class HLSPOC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final backend = StreamBackEnd();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(backend: backend),
        ),
        BlocProvider(
          create: (context) => ChannelCubit(backend: backend),
        ),
      ],
      child: StreamChat(
        client: backend.client,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: LandingPage(),
        ),
      ),
    );
  }
}

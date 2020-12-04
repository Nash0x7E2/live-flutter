import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<CubitChannelState> {
  ChannelCubit() : super(ChannelInitial());
  
  Future<void> configureChannel() async {}
}

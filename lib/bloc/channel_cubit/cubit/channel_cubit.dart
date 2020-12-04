import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:hfs/backend/stream_backend.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

part 'channel_state.dart';

class ChannelCubit extends Cubit<CubitChannelState> {
  ChannelCubit({@required this.backend}) : super(ChannelInitial());
  final StreamBackEnd backend;

  Future<void> configureChannel(final String videoUrl) async {
    // assert(videoUrl != null && videoUrl.isNotEmpty);
    try {
      emit(DataChannelState(isLoading: true));
      final channel = await backend.configureChannel(url: videoUrl);
      emit(DataChannelState(channel: channel));
    } catch (error) {
      emit(DataChannelState(hasError: true, error: error));
    }
  }
}

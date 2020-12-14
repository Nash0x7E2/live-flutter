import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hfs/backend/mux_backend.dart';
import 'package:hfs/models/video_model.dart';
import 'package:meta/meta.dart';

part 'livestream_state.dart';

class LivestreamCubit extends Cubit<LivestreamState> {
  LivestreamCubit({@required this.muxBackend}) : super(LivestreamInitial());
  final MuxBackend muxBackend;

  Future<void> loadStreams() async {
    try {
      emit(DataLiveStreamState(isLoading: true));
      List<Video> videos = await muxBackend.fetchLivestreams();
      emit(DataLiveStreamState(videos: videos));
    } catch (error) {
      emit(
        DataLiveStreamState(
          hasError: true,
          error: "Livestream could not be loaded",
        ),
      );
    }
  }
}

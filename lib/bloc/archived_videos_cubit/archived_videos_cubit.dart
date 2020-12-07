import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hfs/backend/mux_backend.dart';
import 'package:hfs/models/video_model.dart';
import 'package:meta/meta.dart';

part 'archived_videos_state.dart';

class ArchivedVideosCubit extends Cubit<ArchivedVideosState> {
  ArchivedVideosCubit({@required this.muxBackend})
      : assert(muxBackend != null),
        super(ArchivedVideosInitial());

  final MuxBackend muxBackend;

  Future<void> getArchivedVideos() async {
    try {
      emit(DataArchivedVideosState(isLoading: true));
      final videos = await muxBackend.fetchPastLivestreams();
      emit(DataArchivedVideosState(isLoading: false, videos: videos));
    } catch (error) {
      emit(
        DataArchivedVideosState(
          isLoading: false,
          hasError: true,
          error: "Archived videos are currently unavailable",
        ),
      );
    }
  }
}

part of 'livestream_cubit.dart';

@immutable
abstract class LivestreamState extends Equatable {
  const LivestreamState({
    @required this.isLoading,
    @required this.hasError,
    @required this.error,
  });

  final bool isLoading;
  final bool hasError;
  final String error;

  @override
  List<Object> get props => [
        isLoading,
        hasError,
        error,
      ];
}

class LivestreamInitial extends LivestreamState {}

class DataLiveStreamState extends LivestreamState {
  DataLiveStreamState({
    bool isLoading = false,
    bool hasError = false,
    this.videos,
    String error,
  })  : this.videoCount = videos?.length,
        super(
          isLoading: isLoading,
          hasError: hasError,
          error: error,
        );

  final List<Video> videos;
  final int videoCount;

  @override
  List<Object> get props => [...super.props, videos];
}

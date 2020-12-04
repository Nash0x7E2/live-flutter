part of 'stream_cubit.dart';

abstract class CubitStreamState extends Equatable {
  const CubitStreamState({
    @required this.isLoading,
    @required this.hasError,
    @required this.error,
  });
  final bool isLoading;
  final bool hasError;
  final Exception error;

  @override
  List<Object> get props => [
        isLoading,
        hasError,
        error,
      ];
}

class StreamInitial extends CubitStreamState {
  const StreamInitial();
  List<Object> get props => [];
}

class StreamUserState extends CubitStreamState {
  StreamUserState({
    this.hasData = false,
    bool isLoading = false,
    bool hasError = false,
    Exception error,
  }) : super(
          isLoading: isLoading,
          hasError: hasError,
          error: error,
        );

  final bool hasData;

  @override
  List<Object> get props => [...super.props, hasData];
}



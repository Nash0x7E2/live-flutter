part of 'channel_cubit.dart';

abstract class CubitChannelState extends Equatable {
  const CubitChannelState({
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

class ChannelInitial extends CubitChannelState {}

class StreamChannelState extends CubitChannelState {
  StreamChannelState({
    @required bool isLoading,
    @required bool hasError,
    @required Exception error,
    @required this.channel,
  }) : super(
          isLoading: isLoading,
          hasError: hasError,
          error: error,
        );

  final Channel channel;

  @override
  List<Object> get props => [...super.props, channel];
}

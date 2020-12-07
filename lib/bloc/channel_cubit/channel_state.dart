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

class DataChannelState extends CubitChannelState {
  DataChannelState({
    bool isLoading = false,
    bool hasError = false,
    this.channel,
    this.client,
    Exception error,
  }) : super(
          isLoading: isLoading,
          hasError: hasError,
          error: error,
        );

  final Channel channel;
  final Client client;

  @override
  List<Object> get props => [...super.props, channel];
}

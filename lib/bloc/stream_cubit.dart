import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  StreamCubit() : super(StreamInitial());
}

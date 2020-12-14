import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hfs/backend/stream_backend.dart';
import 'package:meta/meta.dart';

part 'stream_state.dart';

class UserCubit extends Cubit<CubitStreamState> {
  UserCubit({@required this.backend})
      : assert(backend != null),
        super(StreamInitial());

  final StreamBackEnd backend;

  Future<void> configureUser({@required final String name}) async {
    assert(name != null && name.isNotEmpty);
    try {
      emit(StreamUserState(isLoading: true));

      await backend.configureUser(
        name: name,
        id: name,
      );

      emit(StreamUserState(hasData: true));
    } catch (exception) {
      emit(StreamUserState(hasError: true, error: exception));
    }
  }
}

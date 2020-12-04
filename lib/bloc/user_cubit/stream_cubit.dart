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
      // TODO(Nash): Call API to dynamically generate a token and id for the user.
      await backend.configureUser(
        name: name,
        id: "nash",
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibmFzaCJ9.9mJyRhgRAINMTKHEue-ZqYHlJ6M2EtWLcsWYkVHuSOc",
      );
      emit(StreamUserState(hasData: true));
    } catch (exception) {
      emit(StreamUserState(hasError: true, error: exception));
    }
  }


}

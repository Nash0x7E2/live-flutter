import 'package:flutter/material.dart';
import 'package:hfs/backend/stream_backend.dart';

class BackendProvider extends InheritedWidget {
  const BackendProvider({
    Key key,
    @required Widget child,
    @required this.backend,
  })  : assert(child != null),
        assert(backend != null),
        super(key: key, child: child);

  final StreamBackEnd backend;

  static StreamBackEnd of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<BackendProvider>()
        .backend;
  }

  @override
  bool updateShouldNotify(BackendProvider old) {
    return old.backend != backend;
  }
}

extension BuildContextExtensions on BuildContext {
  StreamBackEnd get backend => BackendProvider.of(this);
}

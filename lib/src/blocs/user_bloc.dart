import 'dart:async';

import 'package:dart_notes_mobile/src/actions/actions.dart';
import 'package:dart_notes_mobile/src/models/state/user_state.dart';

import 'bloc.dart';
import '../repository/user_repository.dart';

class UserBloc extends Bloc {
  final _userRepository = UserRepository();

  UserState _currentState = UserState();

  final _stateController = StreamController<UserState>.broadcast();
  final _actionsController = StreamController<UserAction>();

  Stream<UserState> get state => _stateController.stream;
  Sink<UserAction> get action => _actionsController.sink;

  UserBloc() {
    _actionsController.sink.add(LoadUserAction());
    _actionsController.stream.listen(_handleAction);
  }

  void _handleAction(UserAction action) async {
    if (action is LoadUserAction) {
      final user = await _userRepository.getUser();
      _currentState = UserState(user: user);
    } else if (action is SignOutUserAction) {
      await _userRepository.deleteUser();
      _currentState = UserState();
    }
    _stateController.sink.add(_currentState);
  }

  @override
  void dispose() {
    _stateController.close();
    _actionsController.close();
  }
}

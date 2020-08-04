import 'dart:async';

import '../actions/actions.dart';
import '../models/state/auth_state.dart';
import '../services/auth_service.dart';
import '../storage.dart';

import 'bloc.dart';

class AuthBloc extends Bloc {
  AuthState _currentState = NonAuthorizedState();

  final _stateController = StreamController<AuthState>();
  final _actionController = StreamController<AuthAction>();

  Stream<AuthState> get state => _stateController.stream;
  Sink<AuthAction> get action => _actionController.sink;

  AuthBloc() {
    _actionController.stream.listen(_handleAction);
  }

  void _handleAction(AuthAction action) async {
    if (action is OfflineAuthAction) {
      final user = await AuthService.logOffline();
      await saveUserToStorage(user: user);
      _currentState = AuthorizedState("Authorized anonymously");
    } else if (action is LogInAction) {
      final user = await AuthService.loginUser(
          username: action.username, password: action.password);
      if (user != null) {
        await saveUserToStorage(user: user);
        _currentState = AuthorizedState("Welcome back, ${action.username}");
      } else {
        _currentState =
            AuthErrorState("Can't SignIn\nTry again or try offline mode.");
      }
    } else if (action is SignInAction) {
      final user = await AuthService.registerUser(
          username: action.username, password: action.password);
      if (user != null) {
        await saveUserToStorage(user: user);
        _currentState = AuthorizedState("Welcome, ${action.username}");
      } else {
        _currentState =
            AuthErrorState("Can't SignUp\nTry again or try offline mode.");
      }
    }
    _stateController.sink.add(_currentState);
  }

  @override
  void dispose() {
    _stateController.close();
    _actionController.close();
  }
}

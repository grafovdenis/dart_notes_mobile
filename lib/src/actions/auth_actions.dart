import 'actions.dart';

// Auth actions
class AuthAction extends Action {}

class LogInAction extends AuthAction {
  final String username;
  final String password;

  LogInAction({this.username, this.password});
}

class SignInAction extends AuthAction {
  final String username;
  final String password;

  SignInAction({this.username, this.password});
}

class OfflineAuthAction extends AuthAction {}

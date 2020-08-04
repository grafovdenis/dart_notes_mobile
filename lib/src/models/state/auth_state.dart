abstract class AuthState {}

class AuthorizedState extends AuthState {
  final String message;

  AuthorizedState(this.message);
}

class NonAuthorizedState extends AuthState {}

class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}

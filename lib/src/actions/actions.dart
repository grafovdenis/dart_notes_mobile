import '../models/user.dart';

abstract class Action {}

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

// User actions
class UserAction extends Action {}

class LoadUserAction extends UserAction {}

class SignOutUserAction extends UserAction {}

// Notes actions
class NotesAction extends Action {}

class LoadNotesAction extends NotesAction {
  final User user;

  LoadNotesAction({this.user});
}

class AddNoteAction extends NotesAction {
  final String title;
  final String content;
  final User user;

  AddNoteAction({this.title, this.content, this.user});

  AddNoteAction copyWith({User user}) {
    return AddNoteAction(
      title: this.title,
      content: this.content,
      user: user,
    );
  }
}

class DeleteNoteAction extends NotesAction {
  final int id;
  final User user;

  DeleteNoteAction({this.id, this.user});

  DeleteNoteAction copyWith({User user}) {
    return DeleteNoteAction(
      id: this.id,
      user: user,
    );
  }
}

import 'actions.dart';
import '../models/user.dart';
import '../models/note.dart';

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

class UpdateNoteAction extends NotesAction {
  final Note note;
  final User user;

  UpdateNoteAction({this.note, this.user});

  UpdateNoteAction copyWith({User user}) {
    return UpdateNoteAction(
      note: this.note,
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

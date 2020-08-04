import '../note.dart';

class NotesState {
  final List<Note> notes;

  const NotesState({this.notes});

  NotesState copyWith({List<Note> notes}) =>
      NotesState(notes: notes ?? this.notes);
}

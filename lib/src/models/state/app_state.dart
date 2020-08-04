import 'notes_state.dart';
import 'user_state.dart';

class AppState {
  final NotesState notesState;
  final UserState userState;

  AppState({this.notesState, this.userState});

  AppState copyWith({NotesState notesState, UserState userState}) {
    return AppState(
      userState: userState ?? this.userState,
      notesState: notesState ?? this.notesState,
    );
  }
}

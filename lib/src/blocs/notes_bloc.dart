import 'dart:async';

import 'package:dart_notes_mobile/src/actions/actions.dart';
import 'package:dart_notes_mobile/src/models/state/notes_state.dart';
import 'package:dart_notes_mobile/src/repository/notes_repository.dart';

import 'bloc.dart';

class NotesBloc extends Bloc {
  final NotesRepository _notesRepository = NotesRepository();

  NotesState _currentState = NotesState();

  final _stateController = StreamController<NotesState>.broadcast();
  final _actionsController = StreamController<NotesAction>();

  Stream<NotesState> get state => _stateController.stream;
  Sink<NotesAction> get action => _actionsController.sink;

  void _handleAction(NotesAction action) async {
    if (action is LoadNotesAction && action.user != null) {
      final notes = await _notesRepository.getNotes(user: action.user);
      _currentState = _currentState.copyWith(notes: notes);
      _stateController.sink.add(_currentState);
    } else if (action is AddNoteAction && action.user != null) {
      final notes = await _notesRepository.addNote(
          title: action.title, content: action.content, user: action.user);
      _currentState = _currentState.copyWith(notes: notes);
      _stateController.sink.add(_currentState);
    } else if (action is DeleteNoteAction && action.user != null) {
      final notes =
          await _notesRepository.deleteNote(id: action.id, user: action.user);
      _currentState = _currentState.copyWith(notes: notes);
      _stateController.sink.add(_currentState);
    } else if (action is UpdateNoteAction && action.user != null) {
      
    }
  }

  NotesBloc() {
    _actionsController.stream.listen(_handleAction);
  }

  @override
  void dispose() {
    _stateController.close();
    _actionsController.close();
  }
}

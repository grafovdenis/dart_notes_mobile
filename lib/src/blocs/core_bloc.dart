import 'dart:async';

import '../models/state/app_state.dart';
import '../models/state/user_state.dart';
import '../actions/actions.dart';

import 'bloc.dart';
import 'user_bloc.dart';
import 'notes_bloc.dart';

class CoreBloc extends Bloc {
  final userBloc = UserBloc();
  final notesBloc = NotesBloc();

  AppState _currentState = AppState();

  final _stateController = StreamController<AppState>();
  final _actionController = StreamController<Action>();

  Stream<AppState> get state => _stateController.stream;
  Sink<Action> get action => _actionController.sink;

  CoreBloc() {
    userBloc.action.add(LoadUserAction());
    userBloc.state.listen((state) {
      if (state is UserState && state.user != null) {
        notesBloc.action.add(LoadNotesAction(user: state.user));
      }
      _currentState = _currentState.copyWith(userState: state);
      _stateController.add(_currentState);
    });
    notesBloc.state.listen((state) {
      _currentState = _currentState.copyWith(notesState: state);
      _stateController.add(_currentState);
    });
    _actionController.stream.listen(_handleAction);
  }

  void _handleAction(Action action) async {
    if (action is UserAction) {
      userBloc.action.add(action);
    } else if (action is LoadNotesAction) {
      notesBloc.action.add(LoadNotesAction(user: _currentState.userState.user));
    } else if (action is AddNoteAction) {
      notesBloc.action.add(action.copyWith(user: _currentState.userState.user));
    } else if (action is DeleteNoteAction) {
      notesBloc.action.add(action.copyWith(user: _currentState.userState.user));
    } else if (action is UpdateNoteAction) {
      notesBloc.action.add(action.copyWith(user: _currentState.userState.user));
    }
  }

  @override
  void dispose() {
    userBloc.dispose();
    notesBloc.dispose();
    _stateController.close();
    _actionController.close();
  }
}

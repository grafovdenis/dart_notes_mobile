import 'package:dart_notes_mobile_v3/src/models/state/notes_state.dart';
import 'package:flutter/material.dart';

import 'package:dart_notes_mobile_v3/src/actions/actions.dart';
import 'package:dart_notes_mobile_v3/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile_v3/src/blocs/core_bloc.dart';
import 'package:dart_notes_mobile_v3/src/models/state/app_state.dart';
import 'package:dart_notes_mobile_v3/src/models/note.dart';
import 'package:dart_notes_mobile_v3/src/widgets/loading_indicator.dart';
import 'package:dart_notes_mobile_v3/src/widgets/new_note_widget.dart';
import 'package:dart_notes_mobile_v3/src/widgets/note_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CoreBloc coreBloc = BlocProvider.of<CoreBloc>(context);
    return Scaffold(
      body: StreamBuilder(
        stream: coreBloc.notesBloc.state,
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data is NotesState) {
            final List<Note> _notes = (snapshot.data as NotesState).notes;
            return RefreshIndicator(
                child: (_notes.isNotEmpty)
                    ? ListView.builder(
                        itemCount: _notes.length,
                        itemBuilder: (context, index) {
                          final data = _notes[index];
                          return NoteWidget(
                            data: data,
                            onDismissed: (DismissDirection direction) async {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Note with id=${data.id} removed"),
                                duration: const Duration(seconds: 1),
                              ));
                              await Future.delayed(const Duration(seconds: 1));
                              coreBloc.action
                                  .add(DeleteNoteAction(id: data.id));
                            },
                          );
                        },
                      )
                    : LayoutBuilder(
                        builder: (context, constants) => SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Container(
                            height: constants.maxHeight,
                            width: constants.maxWidth,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SvgPicture.asset(
                                  'assets/svg/notes.svg',
                                  height: 200,
                                  width: 200,
                                ),
                                Text("What notes are on your mind?"),
                                Text("Tap + to add note")
                              ],
                            ),
                          ),
                        ),
                      ),
                onRefresh: () async => coreBloc.action.add(LoadNotesAction()));
          } else {
            return LoadingIndicator();
          }
        },
      ),
      floatingActionButton: Builder(builder: (context) {
        bool _showButton = true;
        return StatefulBuilder(builder: (context, setState) {
          return (_showButton)
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _showButton = !_showButton;
                    });
                    final bottomSheetController =
                        Scaffold.of(context).showBottomSheet(
                      (_) => NewNoteWidget(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 16,
                    );
                    bottomSheetController.closed.then((_) => setState(() {
                          _showButton = !_showButton;
                        }));
                  },
                )
              : Container();
        });
      }),
    );
  }
}

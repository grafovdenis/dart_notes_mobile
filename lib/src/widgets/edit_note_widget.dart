import 'package:dart_notes_mobile/src/actions/actions.dart';
import 'package:dart_notes_mobile/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile/src/blocs/core_bloc.dart';
import 'package:dart_notes_mobile/src/models/note.dart';
import 'package:flutter/material.dart';

class EditNoteWidget extends StatefulWidget {
  final Note note;
  EditNoteWidget({Key key, this.note}) : super(key: key);

  @override
  _EditNoteWidgetState createState() => _EditNoteWidgetState();
}

class _EditNoteWidgetState extends State<EditNoteWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  final contentPadding = const EdgeInsets.all(16);
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    final CoreBloc coreBloc = BlocProvider.of<CoreBloc>(context);
    final _formKey = GlobalKey<FormState>();
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;

    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          (showTitle)
              ? TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: "Title",
                    contentPadding: const EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                )
              : Container(),
          TextFormField(
            controller: _contentController,
            keyboardType: TextInputType.multiline,
            maxLines: 10,
            minLines: 1,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "Content",
              contentPadding: const EdgeInsets.all(16),
              border: InputBorder.none,
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return "Please enter some text";
              } else {
                return null;
              }
            },
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 100,
                  child: FloatingActionButton.extended(
                    label: Text("Title"),
                    icon: Icon(Icons.title),
                    onPressed: () {
                      setState(() {
                        showTitle = !showTitle;
                      });
                    },
                  ),
                ),
                OutlineButton(
                  child: Icon(Icons.save),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      coreBloc.action.add(UpdateNoteAction(
                          note: widget.note.copyWith(
                        title: _titleController.text,
                        content: _contentController.text,
                      )));
                      Navigator.of(context).pop();
                    }
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  borderSide: BorderSide.none,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:dart_notes_mobile_v3/src/actions/actions.dart';
import 'package:dart_notes_mobile_v3/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile_v3/src/blocs/core_bloc.dart';
import 'package:flutter/material.dart';

class NewNoteWidget extends StatefulWidget {
  NewNoteWidget({Key key}) : super(key: key);

  @override
  _NewNoteWidgetState createState() => _NewNoteWidgetState();
}

class _NewNoteWidgetState extends State<NewNoteWidget> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _contentController = TextEditingController();

  final contentPadding = const EdgeInsets.all(16);
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    final CoreBloc coreBloc = BlocProvider.of<CoreBloc>(context);
    final _formKey = GlobalKey<FormState>();

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
                  child: Icon(Icons.send),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      coreBloc.action.add(AddNoteAction(
                        title: _titleController.text,
                        content: _contentController.text,
                      ));
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

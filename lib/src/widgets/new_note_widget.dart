import 'package:dart_notes_mobile/src/actions/actions.dart';
import 'package:dart_notes_mobile/src/blocs/bloc_provider.dart';
import 'package:dart_notes_mobile/src/blocs/core_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter/material.dart';

import 'color_picker_widget.dart';

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

    Color currentColor = Colors.white;

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // SizedBox(width: 8),
                // ColorPickerWidget(),
                SizedBox(width: 8),
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
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        coreBloc.action.add(AddNoteAction(
                          title: _titleController.text,
                          content: _contentController.text,
                        ));
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

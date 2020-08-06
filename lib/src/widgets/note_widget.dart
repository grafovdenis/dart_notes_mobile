import 'package:dart_notes_mobile/src/widgets/edit_note_widget.dart';

import '../models/note.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note data;
  final Function onDismissed;
  final Function onTap;
  const NoteWidget({Key key, this.data, this.onDismissed, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: onDismissed,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 16),
        child: Icon(Icons.delete),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: Icon(Icons.delete),
      ),
      key: Key("${data.id}"),
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text((data.title.isNotEmpty) ? data.title : data.content),
          subtitle: (data.title.isNotEmpty) ? Text(data.content) : null,
        ),
      ),
    );
  }
}

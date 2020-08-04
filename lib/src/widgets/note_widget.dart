import '../models/note.dart';
import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  final Note data;
  final Function onDismissed;
  const NoteWidget({Key key, this.data, this.onDismissed}) : super(key: key);

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
        onTap: () {
          // Navigator.of(context).pushNamed('/edit_note');
        },
        child: ListTile(
          title: Text((data.title.isNotEmpty) ? data.title : data.content),
          subtitle: (data.title.isNotEmpty) ? Text(data.content) : null,
        ),
      ),
    );
  }
}

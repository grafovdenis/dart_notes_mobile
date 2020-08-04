import 'package:dart_notes_mobile_v3/src/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:dart_notes_mobile_v3/src/pages/notes_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Dart notes"),
      ),
      drawer: DrawerWidget(),
      body: NotesPage(),
    );
  }
}

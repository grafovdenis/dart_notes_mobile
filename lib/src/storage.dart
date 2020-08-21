import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/note.dart';
import 'models/user.dart';

Future<bool> saveUserToStorage({User user}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("user", user.toString());
}

Future<User> getUserFromStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final data = jsonDecode(prefs.getString("user"));
    return User(
      username: data['username'],
      authorization: {
        "access_token": data['authorization']['access_token'],
        "token_type": data['authorization']['token_type'],
        "expires_in": data['authorization']['expires_in'],
        "refresh_token": data['authorization']['refresh_token'],
      },
      isOffline: data['is_offline'],
    );
  } catch (e) {
    return null;
  }
}

Future<void> deleteUserFromStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove("user");
}

Future<List<Note>> getNotesFromStorage() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    final response = prefs.getString("notes");
    final data = jsonDecode(response);
    return List<Note>.generate(
        data.length,
        (index) => Note(
              id: data[index]['id'],
              title: data[index]['title'],
              content: data[index]['content'],
            ));
  } catch (e) {
    print("Notes storage are empty");
    saveNotesToStorage(notes: []);
    return <Note>[];
  }
}

Future<bool> saveNotesToStorage({List<Note> notes}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("notes", "[${notes.join(", ")}]");
}

Future<List<Note>> deleteNoteFromStorage({int id}) async {
  final notes = await getNotesFromStorage();
  notes.removeWhere((element) => element.id == id);
  await saveNotesToStorage(notes: notes);
  return notes;
}

Future<List<Note>> editNoteFromStorage({Note note}) async {
  final notes = await getNotesFromStorage();
  notes.removeWhere((element) => element.id == note.id);
  notes.add(note);
  await saveNotesToStorage(notes: notes);
  return notes;
}

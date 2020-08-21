import 'dart:convert';

import '../api_client.dart';
import '../storage.dart';
import '../models/user.dart';
import '../models/note.dart';

class NotesRepository {
  Future<List<Note>> getNotes({User user}) {
    if (user.isOffline) {
      return _getNotesOffline();
    } else {
      return _getNotesOnline(user: user);
    }
  }

  Future<List<Note>> _getNotesOnline({User user}) async {
    final response = await ApiClient.get(endpoint: '/notes', user: user);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Note>.generate(
          data.length,
          (index) => Note(
                id: data[index]['id'],
                title: data[index]['title'],
                content: data[index]['content'],
              ));
    } else {
      return <Note>[];
    }
  }

  Future<List<Note>> _getNotesOffline() async {
    return getNotesFromStorage();
  }

  Future<List<Note>> addNote({String title, String content, User user}) async {
    if (user.isOffline)
      return _addNoteOffline(title: title, content: content);
    else
      return _addNoteOnline(title: title, content: content, user: user);
  }

  Future<List<Note>> _addNoteOnline(
      {String title, String content, User user}) async {
    final response = await ApiClient.post(
        endpoint: '/notes',
        user: user,
        body: {"title": title, "content": content});
    if (response.statusCode == 200) {
      return _getNotesOnline(user: user);
    } else {
      // TODO modify
      return _getNotesOnline(user: user);
    }
  }

  Future<List<Note>> _addNoteOffline({String title, String content}) async {
    final notes = await _getNotesOffline();
    notes.add(Note(
      id: (notes.isNotEmpty) ? notes.last.id + 1 : 0,
      title: title,
      content: content,
    ));
    saveNotesToStorage(notes: notes);
    return notes;
  }

  Future<List<Note>> deleteNote({int id, User user}) {
    if (user.isOffline) {
      return _deleteNoteOffline(id: id);
    } else {
      return _deleteNoteOnline(id: id, user: user);
    }
  }

  Future<List<Note>> _deleteNoteOffline({int id}) {
    return deleteNoteFromStorage(id: id);
  }

  Future<List<Note>> _deleteNoteOnline({int id, User user}) async {
    final response = await ApiClient.delete(endpoint: '/notes/$id', user: user);
    if (response.statusCode == 200) {
      return _getNotesOnline(user: user);
    } else {
      // TODO modify
      return _getNotesOnline(user: user);
    }
  }

  Future<List<Note>> editNote({Note note, User user}) async {
    if (user.isOffline) {
      return _editNoteOffline(note: note);
    } else {
      return _editNoteOnline(note: note, user: user);
    }
  }

  Future<List<Note>> _editNoteOffline({Note note}) async {
    return editNoteFromStorage(note: note);
  }

  Future<List<Note>> _editNoteOnline({Note note, User user}) async {}
}

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:simple_database/simple_database.dart';

class Notes with ChangeNotifier {
  SimpleDatabase notesDB = SimpleDatabase(
      name: 'notes', fromJson: (fromJson) => Note.fromJson(fromJson));

  List<Note> _items = [];

  Notes() {
    getNotesFromDB().then((tempNotes) {
      _items = tempNotes;
      notifyListeners();
    });
  }

  Future<List<Note>> getNotesFromDB() async {
    List<Note> notes = await notesDB.getAllType<Note>();
    return tempNotes;
  }

  void saveNotesonDB() {
    notesDB.clear();
    notesDB.addAll(_items);
  }

  void deleteNote(String id) {
    _items.removeWhere((note) => note.id == id);
    saveNotesonDB();
    notifyListeners();
  }

  List<Note> get items {
    return [..._items];
  }

  List<Note> get lockedItems {
    return _items.where((noteItem) => noteItem.isLocked).toList();
  }

  void addNote(
    String id,
    String title,
    String text,
  ) {
    _items.add(Note(id: id, title: title, text: text, isLocked: false));
    notifyListeners();
  }

  void updateNote(String noteId, String t, String txt) {
    _items.firstWhere((note) => note.id == noteId).title = t;
    _items.firstWhere((note) => note.id == noteId).text = txt;
    notifyListeners();
  }

  Note openNote(String id) {
    return _items.firstWhere((note) => note.id == id, orElse: () {
      return Note(id: '', title: '', text: '');
    });
  }
}

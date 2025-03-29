import 'package:flutter/material.dart';
import '../models/note_model.dart';

class NotesController extends ValueNotifier<List<Note>> {
  NotesController() : super([]);






  void addNote(Note note) {
    value = [...value, note];
    notifyListeners();
  }






  void updateNote(String id, Note updatedNote) {
    value = value.map((note) => note.id == id ? updatedNote : note).toList();
    notifyListeners();
  }





  void deleteNote(String id) {
    value = value.where((note) => note.id != id).toList();
    notifyListeners();
  }







  List<Note> searchNotes(String query) {
    return value.where((note) =>
      note.title.toLowerCase().contains(query.toLowerCase()) ||
      note.content.toLowerCase().contains(query.toLowerCase())
    ).toList();





    
  }





}
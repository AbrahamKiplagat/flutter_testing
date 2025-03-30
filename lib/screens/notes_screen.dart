import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../controllers/notes_controller.dart';
import '../models/note_model.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}






class _NotesScreenState extends State<NotesScreen> {
  final NotesController _notesController = NotesController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
           body: ValueListenableBuilder<List<Note>>(
        valueListenable: _notesController,
        builder: (context, notes, _) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _calculateColumnCount(context),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemCount: notes.length,
            itemBuilder: (context, index) => _buildNoteCard(notes[index]),
          );
        },
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  int _calculateColumnCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }

  Widget _buildNoteCard(Note note) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    note.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () => _showNoteOptions(note),
                ),
              ],
            ),
            Expanded(
              child: Text(
                note.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
            Wrap(
              spacing: 8,
              children: note.tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
          ],
        ),
      ),
    );
  }

  SpeedDial _buildFAB() {
    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      children: [
        SpeedDialChild(
          label: 'New Notes:',
          child: const Icon(Icons.text_fields),
          onTap: _createNewNote,
        ),
        SpeedDialChild(
          label: 'New Checklists:',
          child: const Icon(Icons.checklist),
          onTap: _createChecklist,
        ),
      ],
    );
  }

  void _createNewNote() {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Your Note',
      content: 'Start writing Note...',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notesController.addNote(newNote);
    _openNoteEditor(newNote);
  }

  void _createChecklist() {
    final newChecklist = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: 'Your Checklist',
      content: '- [ ] Enter notes here\n- [ ] Enter notes here\n',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    _notesController.addNote(newChecklist);
    _openNoteEditor(newChecklist);
  }

  void _openNoteEditor(Note note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text(note.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: TextEditingController(text: note.content),
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Start Typing Notes...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

 

  void _showNoteOptions(Note note) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [




          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () {
              Navigator.pop(context);
              _openNoteEditor(note);
            },
          ),





          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              _notesController.deleteNote(note.id);
              Navigator.pop(context);
            },
          ),
        ],








      ),
    );
  }
}
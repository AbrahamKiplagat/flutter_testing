import 'package:flutter/material.dart';
import 'package:testing/main.dart';
import 'package:testing/themes/custom_theme.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CustomThemeMode>(
      valueListenable: MyApp.customThemeNotifier,
      builder: (context, themeMode, _) {
        final isDark = themeMode == CustomThemeMode.dark;
        final colorScheme = Theme.of(context).colorScheme;

        return Scaffold(
          
          body: Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.grey[850]!, Colors.grey[900]!])
                  : null,
            ),
            child: const Center(
              child: Text(
                'Your notes will appear here',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _createNewNote,
            backgroundColor: isDark ? Colors.teal[800] : Colors.blue,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        );
      },
    );
  }

  void _createNewNote() {
    // Implement note creation logic
  }
}
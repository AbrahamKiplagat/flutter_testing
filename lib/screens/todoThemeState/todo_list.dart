import 'package:flutter/material.dart';
import 'package:testing/widgets/bottom_nav.dart';
import '../todoPriority/todo_screen.dart';
import '../notes/notes_screen.dart';

enum CustomThemeMode { light, dark }

class TodoList extends StatefulWidget {
  final int initialTab;
  const TodoList({super.key, this.initialTab = 0});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late int _selectedIndex;
  CustomThemeMode selectedTheme = CustomThemeMode.light;
  
  // Add this list
  final List<String> appBarTitles = [
    'To-Do List',
    'Notes',
    
  ];

  final List<Map<String, dynamic>> themes = [
    {'name': 'Light Mode', 'mode': CustomThemeMode.light},
    {'name': 'Dark Mode', 'mode': CustomThemeMode.dark},
  ];

  final List<Widget> _screens = [
    const TodoScreen(),
    const NotesScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialTab;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  title: Text(appBarTitles[_selectedIndex]),
  actions: [
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () => Navigator.pushNamed(context, '/settings'),
    ),
  ],
),
      body: Container(
                child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        // Optional customization:
        // selectedColor: Colors.red,
        // unselectedColor: Colors.grey.shade600,
      ),
    );
  }
}
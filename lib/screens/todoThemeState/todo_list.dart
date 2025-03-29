import 'package:flutter/material.dart';
import 'package:testing/widgets/bottom_nav.dart';
import '../todoPriority/todo_screen.dart';
import '../notes/notes_screen.dart';
import 'package:testing/themes/custom_theme.dart';
import 'package:testing/main.dart';

class TodoList extends StatefulWidget {
  final int initialTab;
  const TodoList({super.key, this.initialTab = 0});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late int _selectedIndex;
  
  final List<String> appBarTitles = [
    'To-Do List',
    'Notes',
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
    return ValueListenableBuilder<CustomThemeMode>(
      valueListenable: MyApp.customThemeNotifier,
      builder: (context, themeMode, _) {
        final isDark = themeMode == CustomThemeMode.dark;
        
        return Scaffold(
          appBar: AppBar(
            title: Text(appBarTitles[_selectedIndex]),
            backgroundColor: isDark ? Colors.grey[900] ?? Colors.black : Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
            ],
          ),
          body: Container(
            color: isDark ? Colors.grey[850] ?? Colors.black : Colors.white,
            child: _screens[_selectedIndex],
          ),
          bottomNavigationBar: BottomNav(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            selectedColor: isDark ? Colors.lightBlueAccent : Colors.blueAccent,
            unselectedColor: isDark ? Colors.grey[400] ?? Colors.grey : Colors.grey[600] ?? Colors.grey,
          ),
        );
      },
    );
  }
}
import 'package:flutter/material.dart';
import 'package:testing/widgets/bottom_nav.dart';
import '../todoPriority/todo_screen.dart';
import '../notes/notes_screen.dart';
import '../calender/calendar_screen.dart';
import '../Favorites/favorites_screen.dart';
import '../../main.dart';

enum CustomThemeMode { light, dark, vibrant }

class TodoList extends StatefulWidget {
  final int initialTab;
  const TodoList({super.key, this.initialTab = 0});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  late int _selectedIndex;
  CustomThemeMode selectedTheme = CustomThemeMode.light;

  final List<Map<String, dynamic>> themes = [
    {'name': 'Light Mode', 'mode': CustomThemeMode.light},
    {'name': 'Dark Mode', 'mode': CustomThemeMode.dark},
    {'name': 'Vibrant Mode', 'mode': CustomThemeMode.vibrant},
  ];

  final List<Widget> _screens = [
    const TodoScreen(),
    const NotesScreen(),
    const CalendarScreen(),
    const FavoritesScreen()
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
        title: const Text('To-Do List'),
        actions: [
          DropdownButton<CustomThemeMode>(
            value: selectedTheme,
            items: themes.map<DropdownMenuItem<CustomThemeMode>>((theme) {
              return DropdownMenuItem<CustomThemeMode>(
                value: theme['mode'] as CustomThemeMode,
                child: Text(theme['name'] as String),
              );
            }).toList(),
            onChanged: (CustomThemeMode? newTheme) {
              if (newTheme != null) {
                setState(() {
                  selectedTheme = newTheme;
                  MyApp.themeNotifier.value = newTheme == CustomThemeMode.dark
                      ? ThemeMode.dark
                      : ThemeMode.light;
                });
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: selectedTheme == CustomThemeMode.vibrant
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple, Colors.blue, Colors.pinkAccent],
                )
              : null,
          color: selectedTheme == CustomThemeMode.dark ? Colors.black : null,
        ),
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
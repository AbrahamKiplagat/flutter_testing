import 'package:flutter/material.dart';
import 'package:testing/favorites_screen.dart';
import 'main.dart';
import 'notes_screen.dart';
import 'calendar_screen.dart';
import 'todo_screen.dart';  // ✅ Import the missing class

enum CustomThemeMode { light, dark, vibrant } // ✅ Add custom theme enum

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  CustomThemeMode selectedTheme = CustomThemeMode.light; // ✅ Default theme

  int _selectedIndex = 0;

  final List<Map<String, dynamic>> themes = [
    {'name': 'Light Mode', 'mode': CustomThemeMode.light},
    {'name': 'Dark Mode', 'mode': CustomThemeMode.dark},
    {'name': 'Vibrant Mode', 'mode': CustomThemeMode.vibrant}, // ✅ Fix mode type
  ];

  final List<Widget> _screens = [
    const TodoScreen(),
    const NotesScreen(),
    const CalendarScreen(),
    const FavoritesScreen()
  ];

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
                ) // ✅ Gradient for Vibrant Mode
              : null,
          color: selectedTheme == CustomThemeMode.dark ? Colors.black : Colors.white,
        ),
        child: _screens[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'To-Do',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
             icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

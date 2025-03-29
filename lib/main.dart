import 'package:flutter/material.dart';
import 'screens/todoThemeState/todo_list.dart';
import 'package:testing/themes/settings_screen.dart';       // Add this import

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
  static final customThemeNotifier = ValueNotifier<CustomThemeMode>(CustomThemeMode.light);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const TodoList(),
            '/todo': (context) => const TodoList(initialTab: 0),
            '/notes': (context) => const TodoList(initialTab: 1),
            '/settings': (context) => const SettingsScreen(),  // Add settings route
          },
        );
      },
    );
  }
}
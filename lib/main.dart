import 'package:flutter/material.dart';
import 'screens/todo_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static final themeNotifier = ValueNotifier<ThemeMode>(ThemeMode.light);
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,  // Add this line
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const TodoList(),
            '/todo': (context) => const TodoList(initialTab: 0),
            '/notes': (context) => const TodoList(initialTab: 1),
            '/calendar': (context) => const TodoList(initialTab: 2),
            '/favorites': (context) => const TodoList(initialTab: 3),
          },
        );
      },
    );
  }
}
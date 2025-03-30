import 'package:flutter/material.dart';
import 'package:testing/screens/todoThemeState/todo_list.dart';
import 'package:testing/themes/settings_screen.dart';
import 'package:testing/themes/custom_theme.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
  static final ValueNotifier<CustomThemeMode> customThemeNotifier = ValueNotifier(CustomThemeMode.light);
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.lightBlue,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.lightBlueAccent,
              secondary: Colors.blueAccent,
            ),
            scaffoldBackgroundColor: Colors.grey[900],
          ),
          themeMode: themeMode,
          initialRoute: '/',
          routes: {
            '/': (context) => const TodoList(),
            '/todo': (context) => const TodoList(initialTab: 0),
            '/notes': (context) => const TodoList(initialTab: 1),
            '/settings': (context) => const SettingsScreen(),
          },
        );
      },
    );
  }
}
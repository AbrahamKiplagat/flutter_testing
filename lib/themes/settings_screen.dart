import 'package:flutter/material.dart';
import 'package:testing/screens/todoThemeState/todo_list.dart';
// import 'package:testing/theme/custom_theme.dart';
import 'package:testing/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ValueListenableBuilder<CustomThemeMode>(
        valueListenable: MyApp.customThemeNotifier,
        builder: (context, currentMode, _) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('App Theme', style: TextStyle(fontSize: 18)),
              ),
              ..._buildThemeList(currentMode),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildThemeList(CustomThemeMode currentMode) {
    return [
      RadioListTile<CustomThemeMode>(
        title: const Text('Light Mode'),
        value: CustomThemeMode.light,
        groupValue: currentMode,
        onChanged: _handleThemeChange,
      ),
      RadioListTile<CustomThemeMode>(
        title: const Text('Dark Mode'),
        value: CustomThemeMode.dark,
        groupValue: currentMode,
        onChanged: _handleThemeChange,
      ),
          ];
  }

  void _handleThemeChange(CustomThemeMode? value) {
    if (value != null) {
      MyApp.customThemeNotifier.value = value;
      MyApp.themeNotifier.value = value == CustomThemeMode.dark
          ? ThemeMode.dark
          : ThemeMode.light;
    }
  }
}
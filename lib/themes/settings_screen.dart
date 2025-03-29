import 'package:flutter/material.dart';
import 'package:testing/main.dart';
import 'package:testing/themes/custom_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<CustomThemeMode>(
      valueListenable: MyApp.customThemeNotifier,
      builder: (context, currentMode, _) {
        final isDark = currentMode == CustomThemeMode.dark;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: isDark ? Colors.grey[900] : Colors.blue,
          ),
          body: Container(
            color: isDark ? Colors.grey[850] : Colors.white,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Appearance',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  color: isDark ? Colors.grey[800] : Colors.white,
                  child: Column(
                    children: [
                      RadioListTile<CustomThemeMode>(
                        title: const Text('Light Mode'),
                        value: CustomThemeMode.light,
                        groupValue: currentMode,
                        onChanged: _handleThemeChange,
                      ),
                      const Divider(height: 1),
                      RadioListTile<CustomThemeMode>(
                        title: const Text('Dark Mode'),
                        value: CustomThemeMode.dark,
                        groupValue: currentMode,
                        onChanged: _handleThemeChange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
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
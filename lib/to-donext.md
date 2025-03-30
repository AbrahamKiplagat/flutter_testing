// todo_item.dart
import 'package:flutter/material.dart';
import 'package:testing/widgets/chooseColor/color_picker.dart';

class TodoItem extends StatefulWidget {
  final String title;
  final bool isPriority;
  final Color color;
  final VoidCallback onDismiss;
  final Function(String, bool, Color) onEdit;

  const TodoItem({
    super.key,
    required this.title,
    required this.isPriority,
    required this.color,
    required this.onDismiss,
    required this.onEdit,
  });

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late TextEditingController _editController;
  late bool _currentPriority;
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _editController = TextEditingController(text: widget.title);
    _currentPriority = widget.isPriority;
    _currentColor = widget.color;
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _editController,
              decoration: const InputDecoration(labelText: 'Todo Title'),
            ),
            CheckboxListTile(
              title: const Text('High Priority'),
              value: _currentPriority,
              onChanged: (value) => setState(() => _currentPriority = value!),
            ),
            ColorPickerGrid(
              selectedColor: _currentColor,
              onColorSelected: (color) => setState(() => _currentColor = color),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.onEdit(
                _editController.text,
                _currentPriority,
                _currentColor,
              );
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.color,
      title: Text(
        widget.title,
        style: TextStyle(
          fontWeight: widget.isPriority ? FontWeight.bold : FontWeight.normal,
          decoration: widget.isPriority ? TextDecoration.underline : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _showEditDialog,
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: widget.onDismiss,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _editController.dispose();
    super.dispose();
  }
}import 'package:flutter/material.dart';
import '../chooseColor/color_picker.dart';

class TodoInput extends StatefulWidget {
  final Function(String, bool, Color) onSubmit;

  const TodoInput({super.key, required this.onSubmit});

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final TextEditingController _controller = TextEditingController();
  bool _isPriority = false;
  Color _selectedColor = Colors.blue;

  void _submitTodo() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text, _isPriority, _selectedColor);
      _controller.clear();
      setState(() {
        _isPriority = false;
        _selectedColor = Colors.blue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(labelText: 'Enter Todo'),
          ),
          ColorPickerGrid(
            selectedColor: _selectedColor,
            onColorSelected: (color) => setState(() => _selectedColor = color),
          ),
          Row(
            children: [
              Checkbox(
                value: _isPriority,
                onChanged: (value) => setState(() => _isPriority = value ?? false),
              ),
              const Text('Mark as Priority'),
              const Spacer(),
              ElevatedButton(
                onPressed: _submitTodo,
                child: const Text('Add Todo'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}import 'package:flutter/material.dart';

class ColorPickerGrid extends StatelessWidget {
  final Color selectedColor;
  final Function(Color) onColorSelected;

  const ColorPickerGrid({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  final List<Color> colors = const [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 1,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onColorSelected(colors[index]),
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selectedColor == colors[index]
                    ? _getBorderColor(colors[index])
                    : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: selectedColor == colors[index]
                ? const Icon(Icons.check, 
                    color: Colors.white, 
                    size: 20)
                : null,
          ),
        ),
      ),
    );
  }

  Color _getBorderColor(Color backgroundColor) {
    return backgroundColor.computeLuminance() > 0.5 
        ? Colors.black 
        : Colors.white;
  }
}import 'package:flutter/material.dart';
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
}import 'package:flutter/material.dart';
import '../../widgets/todo/todo_input.dart';
import '../../widgets/todo/todo_item.dart';  // Ensure this import path is correct

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final List<Map<String, dynamic>> _todos = [];

  void _addTodo(String text, bool isPriority, Color color) {
    setState(() {
      _todos.add({
        'title': text, 
        'isPriority': isPriority,
        'color': color,
      });
    });
  }

  void _editTodo(int index, String newText, bool isPriority, Color newColor) {
    setState(() {
      _todos[index] = {
        'title': newText,
        'isPriority': isPriority,
        'color': newColor,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TodoInput(onSubmit: _addTodo),
        Expanded(
          child: ListView.builder(
            itemCount: _todos.length,
            itemBuilder: (context, index) => TodoItem(
              title: _todos[index]['title'],
              isPriority: _todos[index]['isPriority'],
              color: _todos[index]['color'],
              onDismiss: () => setState(() => _todos.removeAt(index)),
              onEdit: (newText, isPriority, newColor) => 
                  _editTodo(index, newText, isPriority, newColor),
            ),
          ),
        ),
      ],
    );
  }
}add a callender to pick starting date, the callender should start from today's date, add description for what a user would do. also add state of the todo where the user will update the todo  of: if it is done if done, on progress, on planning,
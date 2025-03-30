import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.selectedColor = Colors.blueAccent,
    this.unselectedColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: selectedColor,
      unselectedItemColor: unselectedColor,
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
    );
  }
}
import 'package:flutter/material.dart';

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
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: colors.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onColorSelected(colors[index]),
          child: Container(
            decoration: BoxDecoration(
              color: colors[index],
              border: Border.all(
                color: selectedColor == colors[index] 
                    ? Colors.black 
                    : Colors.transparent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }
}
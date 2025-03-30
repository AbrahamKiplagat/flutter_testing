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
          crossAxisCount: 15,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
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
}
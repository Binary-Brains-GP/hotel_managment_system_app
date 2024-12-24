import 'package:design_pattern/core/theming/colors.dart';
import 'package:flutter/material.dart';

class HorizontalTextScroller extends StatefulWidget {
  final Function(String) onCategorySelected;

  const HorizontalTextScroller({
    super.key,
    required this.onCategorySelected,
  });

  @override
  _HorizontalTextScrollerState createState() => _HorizontalTextScrollerState();
}

class _HorizontalTextScrollerState extends State<HorizontalTextScroller> {
  final List<String> roomTypes = [
    "Standard",
    "Luxury",
    "Economy"
  ];
  int selectedIndex = 0; // To track the selected item

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(roomTypes.length, (index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              widget.onCategorySelected(roomTypes[index]); // Notify parent
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                roomTypes[index],
                style: TextStyle(
                  fontSize: isSelected ? 18 : 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? MyColors.myLightBrown : Colors.black54,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

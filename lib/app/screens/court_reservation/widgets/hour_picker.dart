import 'package:flutter/material.dart';

class HourPicker extends StatefulWidget {
  const HourPicker({required this.onTap, super.key});

  final void Function(int)? onTap;

  @override
  HourPickerState createState() => HourPickerState();
}

class HourPickerState extends State<HourPicker> {
  late FixedExtentScrollController _scrollController;
  int _selectedItem = 5;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: _selectedItem);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (context, index) {
            final isSelected = index == _selectedItem;
            final opacity = isSelected ? 1.0 : 0.5;
            final scale = isSelected ? 1.2 : 0.8;
            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: GestureDetector(
                  onTap: () => widget.onTap?.call(index),
                  child: Center(
                    child: Text(
                      '$index:00',
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: 24,
        ),
      ),
    );
  }
}

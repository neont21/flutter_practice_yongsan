//filename: workout_day_selector.dart
import 'package:flutter/material.dart';

class WorkoutDaySelector extends StatefulWidget {
  const WorkoutDaySelector({super.key});

  @override
  State<WorkoutDaySelector> createState() => _WorkoutDaySelectorState();
}

class _WorkoutDaySelectorState extends State<WorkoutDaySelector> {
  List<bool> isSelected = List.filled(7, false);

  void updateIsSelected(int index) {
    isSelected[index] = !isSelected[index];
  }

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: isSelected,
      onPressed: (index) {
        setState(() {
          updateIsSelected(index);
        });
      },
      constraints: const BoxConstraints(
        minHeight: 32,
        minWidth: 32,
      ),
      children: [
        Text('월'),
        Text('화'),
        Text('수'),
        Text('목'),
        Text('금'),
        Text('토'),
        Text('일'),
      ],
    );
  }
}

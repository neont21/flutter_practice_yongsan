//filename: /widgets/workout_tile.dart
import 'package:flutter/material.dart';

import 'workout_day_selector.dart';

class WorkoutTile extends StatelessWidget {
  final int index;
  final String name;
  final String image;
  final int minutes;

  const WorkoutTile({
    super.key,
    required this.index,
    required this.name,
    required this.image,
    required this.minutes,
  });


  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(6),
            image: DecorationImage(
              image: NetworkImage('$image'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${index + 1}.$name',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$minutes분',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () {
                // 삭제 동작 수행
              },
              color: colorScheme.outlineVariant,
              icon: Icon(
                Icons.delete_outline,
                size: textTheme.titleLarge?.fontSize,
              ),
            ),
          ],
        ),
        subtitle:  WorkoutDaySelector(),
      ),
    );
  }
}
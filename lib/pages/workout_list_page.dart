import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/workout.dart';
import '../logics/workout_manager.dart';

class WorkoutListPage extends StatelessWidget {
  final int groupIndex;
  final List<Workout> workouts;
  WorkoutListPage({super.key, required this.groupIndex}):
    workouts = WorkoutManager.groups[groupIndex].workouts;

  // final List<Workout> workouts = WorkoutManager.workouts;

  List<ListTile> getWorkoutList(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    List<ListTile> workoutTiles = [];

    for (var i = 0; i < workouts.length; i++) {
      String name = workouts[i].name;
      String image = workouts[i].imageName;
      int minutes = workouts[i].minutes;

      workoutTiles.add(
        ListTile(
          onTap: () {
            context.go('/workout_home/workout_list/$groupIndex/workout_guide/$i');
          },
          contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          leading: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/workout/$image')),
              shape: BoxShape.circle,
            ),
          ),
          title: Text(
            '${i + 1}. $name',
            style: TextStyle(
              fontSize: textTheme.titleMedium?.fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            '$minutes분',
            style: TextStyle(
              fontSize: textTheme.titleMedium?.fontSize,
              color: colorScheme.secondary,
            ),
          ),
        ),
      );
    }

    return workoutTiles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Workout List'))),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 40, right: 10),
              title: Text(
                '운동',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    color: Colors.grey),
              ),
              trailing: Text(
                '세트 당 소요시간',
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.titleMedium?.fontSize,
                    color: Colors.grey),
              ),
            ),
            ...getWorkoutList(context),
          ],
        ),
      ),
    );
  }
}

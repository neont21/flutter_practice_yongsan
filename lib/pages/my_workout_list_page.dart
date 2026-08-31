import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/my_workout.dart';
// import '../sample_data.dart';
import '../widgets/workout_tile.dart';
import '../logics/my_workout_provider.dart';
import 'add_workout_dialog.dart';

class MyWorkoutListPage extends StatefulWidget {
  const MyWorkoutListPage({super.key});

  @override
  State<MyWorkoutListPage> createState() => _MyWorkoutListPageState();
}

class _MyWorkoutListPageState extends State<MyWorkoutListPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      Provider.of<MyWorkoutProvider>(context,listen:false).fetchAllMyWorkouts();
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<MyWorkoutProvider>(context,listen:false).fetchAllMyWorkouts();
    });
    // SampleData.insertSampleData();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text('MyWorkoutList')),
      body: Consumer<MyWorkoutProvider>(
        builder: (context, myWorkoutProvider, child) {
          List<MyWorkout> workouts = myWorkoutProvider.workouts;
          if (workouts.isEmpty) {
            return Center(child: Text('운동 데이터가 로드되지 않았습니다.'));
          }
          return ListView.builder(
            controller: _scrollController,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: workouts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const ListTile(
                  contentPadding: EdgeInsets.only(left: 45, right: 20),
                  leading: Text(
                    '운동',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Text(
                    '세트 당 소요시간',
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              final workout = workouts[index - 1];
              return WorkoutTile(
                key: ObjectKey(workout),
                index: index - 1,
                name: workout.name,
                image: workout.imageURL,
                minutes: workout.minutes,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(child: AddWorkoutDialog());
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/my_workout.dart';

class MyWorkoutProvider extends ChangeNotifier{
  final List<MyWorkout> _workouts = [
    MyWorkout(
      name: '어깨 스트레칭',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
      minutes: 10,
    ),
    MyWorkout(
      name: '전사 자세',
      imageURL: 'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fwarrior_pose.png?alt=media&token=c4ab3994-c66d-458c-a53d-fa3e02ee5671',
      minutes: 15,
    ),
  ];

  List<MyWorkout> get workouts => UnmodifiableListView(_workouts);

  void addMyWorkout(MyWorkout workout) {
    _workouts.add(workout);
    notifyListeners();
  }
}
import 'dart:collection';
import 'package:flutter/material.dart';
import '../services/firebase_auth_service.dart';
import '../services/firestore_service.dart';
import '../models/my_workout.dart';

class MyWorkoutProvider extends ChangeNotifier {
  final FirestoreService _firebaseStore = FirestoreService();
  final FirebaseAuthService _auth = FirebaseAuthService();

  final List<MyWorkout> _workouts = [
    // MyWorkout(
    //   name: '어깨 스트레칭',
    //   imageURL:
    //       'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
    //   minutes: 10,
    // ),
    // MyWorkout(
    //   name: '전사 자세',
    //   imageURL:
    //       'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fwarrior_pose.png?alt=media&token=c4ab3994-c66d-458c-a53d-fa3e02ee5671',
    //   minutes: 15,
    // ),
  ];

  List<MyWorkout> get workouts => UnmodifiableListView(_workouts);

  Future<void> addMyWorkout(MyWorkout workout) async {
    workout.uid = _auth.user?.uid;
    await _firebaseStore.createMyWorkout(workout);
    _workouts.add(workout);
    notifyListeners();
  }

  Future<void> deleteMyWorkout(int index) async {
    _workouts.removeAt(index);
    notifyListeners();
  }

  Future<void> updateMyWorkoutDays({
    required List<bool> isSelected,
    required int workoutIndex,
  }) async {
    _workouts[workoutIndex].workoutDays = isSelected;
    notifyListeners();
  }

  Future<void> fetchAllMyWorkouts() async {
    if (_auth.user == null) {
      return;
    }
    final fetchedWorkouts = await _firebaseStore.fetchAllMyWorkout(
      uid: _auth.user!.uid,
      limit: 5,
      lastWorkout: _workouts.lastOrNull,
    );
    _workouts.addAll(fetchedWorkouts);
    notifyListeners();
  }
}

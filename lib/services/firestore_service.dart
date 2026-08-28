import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/my_workout.dart';

class FirestoreService {
  final FirebaseFirestore _fs = FirebaseFirestore.instance;

  Future<void> createMyWorkout(MyWorkout myWorkout) async {
    try {
      final myWorkoutCollection = _fs.collection('myWorkouts');
      final docRef = await myWorkoutCollection.add(myWorkout.toMap());
      docRef.update({'id': docRef.id});
    } catch (e) {
      throw Exception('db error: $e');
    }
  }

  Future<MyWorkout?> readMyWorkout(String workoutId) async {
    try {

    } catch (e) {
      throw Exception('db error: $e');
    }
    return null;
  }

  Future<void> updateMyWorkout(MyWorkout myWorkout) async {
    try {

    } catch (e) {
      throw Exception('db error: $e');
    }
  }

  Future<void> deleteMyWorkout(String workoutId) async {
    try {

    } catch (e) {
      throw Exception('db error: $e');
    }
  }
}
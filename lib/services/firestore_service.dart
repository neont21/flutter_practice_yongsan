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
      final myWorkoutCollection = _fs.collection('myWorkouts');
      final docRef = myWorkoutCollection.doc(workoutId);
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        throw Exception('no data');
      }
      final mapData = docSnapshot.data()!;
      return MyWorkout.fromMap(mapData);
    } catch (e) {
      throw Exception('db error: $e');
    }
  }

  Future<List<MyWorkout>> fetchAllMyWorkout({
    required String uid,
    int limit = 5,
    MyWorkout? lastWorkout,
  }) async {
    try {
      final myWorkoutCollection = _fs.collection('myWorkouts');
      Query<Map<String, dynamic>> query = myWorkoutCollection
          .where('uid', isEqualTo: uid)
          .orderBy('createdAt')
          .orderBy('id')
          .limit(limit);
      if (lastWorkout != null) {
        query = query.startAfter([
          Timestamp.fromDate(lastWorkout.createdAt),
          lastWorkout.id,
        ]);
      }
      final querySnapshot = await query.get();
      final docSnapshotList = querySnapshot.docs;
      List<MyWorkout> returnData = [];
      for (final doc in docSnapshotList) {
        final mapData = doc.data();
        returnData.add(MyWorkout.fromMap(mapData));
      }
      return returnData;
    } catch (e) {
      throw Exception('db error: $e');
    }
  }

  Future<void> updateMyWorkout(MyWorkout myWorkout) async {
    try {} catch (e) {
      throw Exception('db error: $e');
    }
  }

  Future<void> deleteMyWorkout(String workoutId) async {
    try {} catch (e) {
      throw Exception('db error: $e');
    }
  }
}

import 'models/my_workout.dart';
import 'services/firebase_auth_service.dart';
import 'services/firestore_service.dart';

class SampleData{
  static final firestoreService=FirestoreService();
  static final authService=FirebaseAuthService();
  static final List<MyWorkout> workoutsSample = [
    MyWorkout(
      name: '레그레이즈1',
      minutes: 15,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fside_lunge.png?alt=media&token=9c41e60c-67f7-4029-a927-fb4e75317c5c',
      workoutDays: [true, false, true, false, false, false, false],
    ),
    MyWorkout(
      name: '레그레이즈2',
      minutes: 25,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fseated_forward_bend.png?alt=media&token=a5c92472-8f80-4665-8159-98b04e3895e2',
      workoutDays: [false, false, false, false, false, true, false],
    ),
    MyWorkout(
      name: '레그레이즈3',
      minutes: 35,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fdonkey_kick.png?alt=media&token=b3fca647-5859-4222-b150-3bf089d99558',
      workoutDays: [false, false, false, false, false, true, true],
    ),
    MyWorkout(
      name: '레그레이즈4',
      minutes: 15,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
      workoutDays: [false, false, true, false, false, true, false],
    ),
    MyWorkout(
      name: '레그레이즈5',
      minutes: 25,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Flunge.png?alt=media&token=322d94d7-8859-47b8-b684-1902a65cf3c4',
      workoutDays: [false, false, false, false, true, false, true],
    ),
    MyWorkout(
      name: '레그레이즈6',
      minutes: 35,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fside_bend_stretch.png?alt=media&token=647897f3-b7b4-4379-84a8-5313f3b757e1',
      workoutDays: [true, false, true, false, false, false, false],
    ),
    MyWorkout(
      name: '레그레이즈7',
      minutes: 25,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fdonkey_kick.png?alt=media&token=b3fca647-5859-4222-b150-3bf089d99558',
      workoutDays: [true, true, false, false, false, false, false],
    ),
    MyWorkout(
      name: '레그레이즈8',
      minutes: 15,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fside_lunge.png?alt=media&token=9c41e60c-67f7-4029-a927-fb4e75317c5c',
      workoutDays: [false, false, true, true, false, false, false],
    ),
    MyWorkout(
      name: '레그레이즈9',
      minutes: 35,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fshoulder_stretch.png?alt=media&token=05c3ca57-586e-4c32-8ff7-c2aa88503d4c',
      workoutDays: [false, false, false, false, false, true, true],
    ),
    MyWorkout(
      name: '레그레이즈10',
      minutes: 25,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Flunge.png?alt=media&token=322d94d7-8859-47b8-b684-1902a65cf3c4',
      workoutDays: [false, false, false, false, true, true, false],
    ),
    MyWorkout(
      name: '레그레이즈11',
      minutes: 15,
      imageURL:
      'https://firebasestorage.googleapis.com/v0/b/workouttracker-pre.firebasestorage.app/o/my_workouts%2Fseated_forward_bend.png?alt=media&token=a5c92472-8f80-4665-8159-98b04e3895e2',
      workoutDays: [false, true, false, false, false, false, true],
    ),
  ];

  static void insertSampleData()async{
    int i=1;
    DateTime now=DateTime.now();
    for(var workout in workoutsSample) {
      workout.createdAt=now.add(Duration(seconds: i++));
      workout.uid=authService.user?.uid;
      await firestoreService.createMyWorkout(workout);
    }
  }
}
import 'dart:core';

class MyWorkout {
  String? id;
  String name;
  String imageURL;
  int minutes;
  List<bool> workoutDays = List.filled(7, false, growable: false);
  String? uid;
  DateTime createdAt;

  MyWorkout({
    this.id,
    required this.name,
    required this.imageURL,
    required this.minutes,
    this.uid,
    List<bool>? workoutDays,
    DateTime? createAt,
    // }): workoutDays=workoutDays??List.filled(7, false, growable: false);
  }) : workoutDays = _normalizeDays(workoutDays),
       createdAt = createAt ?? DateTime.now();

  static List<bool> _normalizeDays(List<bool>? days) {
    assert(days == null || days.length == 7, '운동 요일의 Length가 7이어야 합니다');
    if (days == null) {
      return List.filled(7, false, growable: false);
    }
    return List<bool>.of(days, growable: false);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'minutes': minutes,
      'imageURL': imageURL,
      'workoutDays': workoutDays,
      'uid': uid,
      'createAt': createdAt,
    };
  }
}

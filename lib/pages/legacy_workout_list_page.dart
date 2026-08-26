import 'package:flutter/material.dart';

class WorkoutListPage extends StatelessWidget {
  WorkoutListPage({super.key});

  final List<Map<String, dynamic>> workoutList = [
    {'name': '스쿼트', 'image': 'squat.png', 'minutes': 30},
    {'name': '마운틴 클라이머', 'image': 'mountain_climber.png', 'minutes': 20},
    {'name': '푸시업', 'image': 'push_up.png', 'minutes': 15},
    {'name': '윗몸 일으키기', 'image': 'sit_up.png', 'minutes': 15},
    {'name': '사이드 런지', 'image': 'side_lunge.png', 'minutes': 20},
    {'name': '덩키 킥', 'image': 'donkey_kick.png', 'minutes': 30},
    {'name': '사이드 플랭크', 'image': 'side_plank.png', 'minutes': 20},
    {'name': '리버스 플랭크', 'image': 'reverse_plank.png', 'minutes': 15},
    {'name': '힙 브릿지', 'image': 'hip_bridge.png', 'minutes': 25},
    {'name': '어꺠 스트레칭', 'image': 'shoulder_stretch.png', 'minutes': 15},
    {'name': '햄스트링', 'image': 'hamstring_stretch.png', 'minutes': 10},
  ];

  List<Row> getWorkoutList() {
    List<Row> workoutRows = [];

    for (var i = 0; i < workoutList.length; i++) {
      String name = workoutList[i]['name'];
      String image = workoutList[i]['image'];
      int minutes = workoutList[i]['minutes'];

      workoutRows.add(
        Row(
          spacing: 20,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/$image')),
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text('${i + 1}. $name', style: TextStyle(fontSize: 20)),
            ),
            Text(
              '$minutes 분',
              style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            )
          ],
        ),
      );
    }

    return workoutRows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Workout List'))),
      body: Padding(
        padding: EdgeInsetsGeometry.all(20),
        child: Column(
          spacing: 20,
          children: getWorkoutList(),
        ),
      ),
    );
  }
}
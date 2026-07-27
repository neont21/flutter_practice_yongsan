import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'workout_list_page.dart';
import 'workout_guide_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: const LandingPage(),
      // home: WorkoutListPage(),
      home: WorkoutGuidePage(),
      theme: ThemeData(
        fontFamily: 'Pretendard',
      ),
    );
  }
}


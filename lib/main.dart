import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'landing_page.dart';
import 'workout_list_page.dart';
import 'workout_guide_page.dart';
import 'workout_home_page.dart';

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
      // home: WorkoutGuidePage(),
      home: WorkoutHomePage(),
      theme: FlexThemeData.light(
        scheme: FlexScheme.blueWhale,
        fontFamily: 'Pretendard',
        subThemesData: const FlexSubThemesData(
          appBarBackgroundSchemeColor: SchemeColor.primary,
        )
      ),
    );
  }
}


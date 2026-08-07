import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'workout_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
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


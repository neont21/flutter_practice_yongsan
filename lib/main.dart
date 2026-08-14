import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'workout_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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


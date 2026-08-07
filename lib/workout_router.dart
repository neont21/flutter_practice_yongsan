import 'package:go_router/go_router.dart';
import 'landing_page.dart';
import 'workout_home_page.dart';
import 'workout_list_page.dart';
import 'workout_guide_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => LandingPage()),
    GoRoute(
      path: '/workout_home',
      builder: (context, state) => WorkoutHomePage(),
      routes: [
        GoRoute(
          path: 'workout_list/:group_index',
          builder: (context, state) {
            String? groupIndexStream = state.pathParameters['group_index'];
            final int groupIndex = int.parse(groupIndexStream!);
            return WorkoutListPage(groupIndex: groupIndex);
          },
          routes: [
            GoRoute(
              path: 'workout_guide/:workout_index',
              builder: (context, state) {
                String? workoutIndexStream =
                    state.pathParameters['workout_index'];
                final int workoutIndex = int.parse(workoutIndexStream!);
                String? groupIndexStream = state.pathParameters['group_index'];
                final int groupIndex = int.parse(groupIndexStream!);
                return WorkoutGuidePage(
                  workoutIndex: workoutIndex,
                  groupIndex: groupIndex,
                );
              },
            ),
          ],
        ),
      ],
    ),
  ],
);

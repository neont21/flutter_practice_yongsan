import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'workout_shell.dart';
import 'landing_page.dart';
import 'workout_home_page.dart';
import 'workout_list_page.dart';
import 'workout_guide_page.dart';
import 'settings_page.dart';
import 'login_page.dart';
import 'registration_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'home',
);
final GlobalKey<NavigatorState> _settingsNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'settings');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(path: '/', builder: (context, state) => LandingPage()),
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state, navigationShell) =>
          WorkoutShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: [
            GoRoute(
              path: '/workout_home',
              builder: (context, state) => WorkoutHomePage(),
              routes: [
                GoRoute(
                  path: 'workout_list/:group_index',
                  builder: (context, state) {
                    String? groupIndexStream =
                        state.pathParameters['group_index'];
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
                        String? groupIndexStream =
                            state.pathParameters['group_index'];
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
        ),
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => SettingsPage(),
              routes: [
                GoRoute(
                  path: 'login',
                  builder: (context, state) => LoginPage(),
                  routes: [
                    GoRoute(
                      path: 'registration',
                      builder: (context, state) => RegistrationPage(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

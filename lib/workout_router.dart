import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/workout_shell.dart';
import 'pages/landing_page.dart';
import 'pages/workout_home_page.dart';
import 'pages/my_workout_list_page.dart';
import 'pages/workout_list_page.dart';
import 'pages/workout_guide_page.dart';
import 'pages/settings_page.dart';
import 'pages/login_page.dart';
import 'pages/registration_page.dart';
import 'pages/profile_page.dart';

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
  redirect: (context, state) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (state.uri.path != '/settings/login/registration' &&
          state.uri.path != '/settings/reset_password' &&
          state.uri.path != '/') {
        return '/settings/login';
      }
    } else {
      if (state.uri.path == '/settings/login' ||
          state.uri.path == '/settings/login/registration') {
        return '/settings';
      }
    }
  },
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
                  path: 'my_workout_list',
                  builder: (context, state) {
                    return MyWorkoutListPage();
                  },
                ),
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
                  path: 'profile',
                  builder: (context, state) => ProfilePage(),
                ),
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

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:workout_tracker_2026/show_snackbar.dart';
import 'firebase_auth_service.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});
  final FirebaseAuthService _auth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Setting Menu', style: Theme.of(context).textTheme.bodyLarge),
            OutlinedButton(
              onPressed: () {
                context.go('/settings/profile');
              },
              child: Text('Profile'),
            ),
            OutlinedButton(
              onPressed: () {
                _auth.isLoggedIn()
                    ? _auth
                          .signOut()
                          .then((value) {
                            showSnackBar('로그아웃 완료');
                            context.go('/workout_home');
                          })
                          .catchError((error) {
                            showSnackBar('$error');
                          })
                    : context.go('/settings/login');
              },
              child: _auth.isLoggedIn()
                  ? Text('log out')
                  : Text('go to LoginPage'),
            ),
          ],
        ),
      ),
    );
  }
}

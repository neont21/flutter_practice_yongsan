import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutShell extends StatelessWidget {
  final StatefulNavigationShell _navigationShell;
  const WorkoutShell({super.key, required this._navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'home',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
        onDestinationSelected: (index) {
          _navigationShell.goBranch(
            index,
            initialLocation: index == _navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

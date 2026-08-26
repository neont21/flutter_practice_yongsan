import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../widgets/dashboard_card.dart';
import '../logics/workout_manager.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  // final int _dailyMinutes = 450;
  final int _dailyGoal = 500;
  // final int _dailyKcal = 2400;
  final int _monthlyHours = 403;
  final int _monthlyGoal = 450;
  final int _lastMonthlyHours = 393;

  final NumberFormat commaThousands = NumberFormat.decimalPattern();

  late Future<({int calories, int minutes})> _todayData;

  void continueWorkout() {
    WorkoutManager.getRecentWorkout().then((recentWorkout) {
      if (!mounted) {
        return;
      }
      int groupIndex = recentWorkout.groupIndex;
      int workoutIndex = recentWorkout.workoutIndex;

      if (groupIndex == -1) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('최근 운동이 없습니다.'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        context.go(
          '/workout_home/workout_list/$groupIndex/workout_guide/$workoutIndex',
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // WorkoutManager.resetTodayWorkoutData();
    _todayData = WorkoutManager.getTodayWorkoutData();
  }

  @override
  void didUpdateWidget(covariant WorkoutHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    _todayData = WorkoutManager.getTodayWorkoutData();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // part A
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/home/runner_icon.png', width: 24),
                  Image.asset('assets/home/notifications_icon.png', width: 24),
                ],
              ),
            ),
            // part B
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '반가워요.',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '건강을 위한 한 걸음\n',
                            style: textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          TextSpan(
                            text: '오늘도 힘차게 운동을 해 볼까요?\n',
                            style: textTheme.bodyMedium,
                          ),
                          TextSpan(
                            text: '> 내 프로필',
                            style: textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      Image.asset('assets/home/half_circle.png', width: 132),
                      Positioned(
                        left: 16,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/home/me.png'),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.blue, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // part C
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: DashboardCard(
                      labelIcon: Icon(
                        Icons.push_pin_outlined,
                        size: textTheme.labelLarge?.fontSize,
                        color: colorScheme.outline,
                      ),
                      labelText: Text(
                        'Today',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                      info: FutureBuilder<({int minutes, int calories})>(
                        future: _todayData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(child: Text('Data Error'));
                          }
                          // int? data = snapshot.data;
                          final workoutMinutes = snapshot.data?.minutes ?? 0;
                          final workoutCalories = snapshot.data?.calories ?? 0;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: CircularProgressIndicator(
                                      value: workoutMinutes / _dailyGoal,
                                      color: Colors.blue,
                                      backgroundColor:
                                          colorScheme.outlineVariant,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsGeometry.symmetric(
                                      vertical: 20,
                                    ),
                                    child: Text.rich(
                                      textAlign: TextAlign.center,
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '운동 시간\n',
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                  color: colorScheme.outline,
                                                ),
                                          ),
                                          TextSpan(
                                            text: '$workoutMinutes분',
                                            style: textTheme.titleLarge
                                                ?.copyWith(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '소모 칼로리\n',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          // '${commaThousands.format(_dailyKcal)} kcal',
                                          '${commaThousands.format(workoutCalories)} kcal',
                                      style: textTheme.bodyLarge?.copyWith(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: DashboardCard(
                      labelIcon: Icon(
                        Icons.calendar_month_outlined,
                        size: textTheme.labelLarge?.fontSize,
                        color: colorScheme.outline,
                      ),
                      labelText: Text(
                        'Monthly',
                        style: textTheme.labelLarge?.copyWith(
                          color: colorScheme.outline,
                        ),
                      ),
                      info: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: CircularProgressIndicator(
                                  value: _monthlyHours / _monthlyGoal,
                                  color: Colors.blue,
                                  backgroundColor: colorScheme.outlineVariant,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsGeometry.symmetric(
                                  vertical: 20,
                                ),
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '운동 시간\n',
                                        style: textTheme.titleMedium?.copyWith(
                                          color: colorScheme.outline,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '$_monthlyHours시간',
                                        style: textTheme.titleLarge?.copyWith(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text.rich(
                            textAlign: TextAlign.center,
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '지난 달 대비\n',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      '${_monthlyHours - _lastMonthlyHours}시간 ',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '더 했어요',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // part D
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: DashboardCard(
                        routeOnTap: () {
                          context.go('/workout_home/workout_list/0');
                        },
                        labelIcon: Icon(
                          Icons.run_circle_outlined,
                          size: textTheme.labelLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: Text(
                          '그룹 1',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        info: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Image.asset('assets/home/group1.png'),
                            ),
                            Flexible(
                              flex: 6,
                              child: Text(
                                '아침을 여는\n5가지 운동',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        bgColor: Colors.yellow.shade50,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: DashboardCard(
                        routeOnTap: () {
                          context.go('/workout_home/workout_list/1');
                        },
                        labelIcon: Icon(
                          Icons.run_circle_outlined,
                          size: textTheme.labelLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: Text(
                          '그룹 2',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        info: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Image.asset('assets/home/group2.png'),
                            ),
                            Flexible(
                              flex: 6,
                              child: Text(
                                '근력을 키우는\n7가지 운동',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        bgColor: Colors.blue.shade50,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: 1 / 1,
                      child: DashboardCard(
                        routeOnTap: () {
                          context.go('/workout_home/workout_list/2');
                        },
                        labelIcon: Icon(
                          Icons.run_circle_outlined,
                          size: textTheme.labelLarge?.fontSize,
                          fontWeight: FontWeight.bold,
                        ),
                        labelText: Text(
                          '그룹 3',
                          style: textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        info: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 4,
                              child: Image.asset('assets/home/group3.png'),
                            ),
                            Flexible(
                              flex: 6,
                              child: Text(
                                '하루를 마무리\n하는 4가지 운동',
                                style: textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        bgColor: Colors.red.shade50,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: DashboardCard(
               labelIcon: Icon(
                  Icons.surfing_outlined,
                  size: 20,
                  color: colorScheme.shadow,
                ),
                labelText: Text(
                  '나만의 운동',
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.shadow,
                  ),
                ),
                info: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            context.go('/workout_home/my_workout_list');
                          },
                          splashRadius: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                routeOnTap: () {

                },
              ),
            ),
            // part E
            Expanded(
              flex: 2,
              child: DashboardCard(
                routeOnTap: () {
                  continueWorkout();
                },
                labelIcon: Icon(
                  Icons.repeat_outlined,
                  size: textTheme.titleMedium?.fontSize,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
                labelText: Text(
                  '운동 이어서 하기',
                  style: textTheme.titleMedium?.copyWith(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                info: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset('assets/home/continue.png'),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(right: 20),
                        child: Text(
                          '당신의 몸은 해낼 수 있다.\n당신의 마음만 설득하면 된다.',
                          style: textTheme.titleLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

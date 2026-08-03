import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dashboard_card.dart';

class WorkoutHomePage extends StatelessWidget {
  WorkoutHomePage({super.key});

  final int _dailyMinutes = 450;
  final int _dailyGoal = 500;
  final int _dailyKcal = 2400;
  final int _monthlyHours = 403;
  final int _monthlyGoal = 450;
  final int _lastMonthlyHours = 393;

  final NumberFormat commaThousands = NumberFormat.decimalPattern();

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
                                  value: _dailyMinutes / _dailyGoal,
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
                                        text: '$_dailyMinutes분',
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
                                  text: '소모 칼로리\n',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: colorScheme.outline,
                                  ),
                                ),
                                TextSpan(
                                  text: '${commaThousands.format(_dailyKcal)} kcal',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.blue,
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
                              padding: EdgeInsetsGeometry.symmetric(vertical: 20),
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
                            ),],
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
                                  text: '${_monthlyHours - _lastMonthlyHours}시간 ',
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
            // part E
            Expanded(
              flex: 2,
              child: DashboardCard(
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

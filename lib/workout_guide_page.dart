import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'workout_manager.dart';
import 'workout.dart';

class WorkoutGuidePage extends StatefulWidget {
  final int workoutIndex;
  final int groupIndex;

  const WorkoutGuidePage({
    super.key,
    required this.workoutIndex,
    required this.groupIndex,
  });

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final _player = AudioPlayer();
  Timer? _timer;
  bool _isPlaying = false;

  late List<Workout> workouts;

  late Workout _currentWorkout;
  late int _remainSeconds;
  int _workoutIndex = 0;

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.loop);
    workouts = WorkoutManager.groups[widget.groupIndex].workouts;
    _workoutIndex = widget.workoutIndex;
    _currentWorkout = workouts[_workoutIndex];
    _remainSeconds = _currentWorkout.minutes * 60;

    WorkoutManager.increaseTodayWorkoutData(minutes: _currentWorkout.minutes, calories: _currentWorkout.kcal);
    WorkoutManager.setRecentWorkout(widget.groupIndex, _workoutIndex);
  }

  @override
  void dispose() {
    _player.dispose();
    _timer?.cancel();
    super.dispose();
  }

  IconButton buildPlayButton() {
    // _isPlaying = _player.state == PlayerState.playing;
    return _isPlaying
        ? IconButton(
            onPressed: () async {
              await _player.pause();
              setState(() {
                _isPlaying = false;
              });
              _timer?.cancel();
            },
            icon: Icon(
              Icons.pause_circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            iconSize: 70,
          )
        : IconButton(
            onPressed: () async {
              await _player.play(
                AssetSource('audio/${_currentWorkout.audioName}'),
              );
              setState(() {
                _isPlaying = true;
              });
              _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
                setState(() {
                  _remainSeconds--;
                });
                if (_remainSeconds <= 0) {
                  timer.cancel();
                  _remainSeconds = 180;
                  _player.stop();
                  setState(() {
                    _isPlaying = false;
                  });
                }
              });
            },
            icon: Icon(
              Icons.play_circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            iconSize: 70,
          );
  }

  void _next() {
    _workoutIndex = (_workoutIndex + 1) % workouts.length;
    _currentWorkout = workouts[_workoutIndex];
    _remainSeconds = _currentWorkout.minutes * 60;
    WorkoutManager.increaseTodayWorkoutData(minutes: _currentWorkout.minutes, calories: _currentWorkout.kcal);
    WorkoutManager.setRecentWorkout(widget.groupIndex, _workoutIndex);
  }

  void _prev() {
    _workoutIndex = (_workoutIndex - 1) % workouts.length;
    _currentWorkout = workouts[_workoutIndex];
    _remainSeconds = _currentWorkout.minutes * 60;
    WorkoutManager.increaseTodayWorkoutData(minutes: _currentWorkout.minutes, calories: _currentWorkout.kcal);
    WorkoutManager.setRecentWorkout(widget.groupIndex, _workoutIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout Guide'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _currentWorkout.name,
                style: TextStyle(
                  fontSize: Theme.of(
                    context,
                  ).textTheme.headlineMedium?.fontSize,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  color: Theme.of(context).colorScheme.primary,
                  decorationColor: Theme.of(context).colorScheme.secondary,
                  decorationThickness: 2.0,
                ),
              ),
              Text(
                _currentWorkout.description,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                  color: Theme.of(context).colorScheme.primaryFixedDim,
                ),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/workout/${_currentWorkout.imageName}',
                  ),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _prev();
                      });
                    },
                    icon: Icon(Icons.arrow_back_ios_new),
                    iconSize: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _next();
                      });
                    },
                    icon: Icon(Icons.arrow_forward_ios),
                    iconSize: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 160,
                  height: 100,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '운동 내용',
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        _currentWorkout.target,
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.fontSize,
                          color: Theme.of(context).colorScheme.primaryFixedDim,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 160,
                  height: 100,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        '이런 사람에게 강추!',
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.titleMedium?.fontSize,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        _currentWorkout.recommend,
                        style: TextStyle(
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.fontSize,
                          color: Theme.of(context).colorScheme.primaryFixedDim,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Text(
                      '${_remainSeconds ~/ 60}분 ${_remainSeconds % 60}초',
                      style: TextStyle(
                        fontSize: Theme.of(
                          context,
                        ).textTheme.titleLarge?.fontSize,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          buildPlayButton(),
        ],
      ),
    );
  }
}

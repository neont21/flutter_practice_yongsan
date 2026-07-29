import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class WorkoutGuidePage extends StatefulWidget {
  const WorkoutGuidePage({super.key});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final _player = AudioPlayer();
  int _remainTime = 180;
  Timer? _timer;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.loop);
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
              await _player.play(AssetSource('audio/squat.mp3'));
              setState(() {
                _isPlaying = true;
              });
              _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
                setState(() {
                  _remainTime--;
                });
                if (_remainTime <= 0) {
                  timer.cancel();
                  _remainTime = 180;
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
                '스쿼트',
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
                '하체 근력을 강화하고\n탄력 있는 엉덩이 라인을 만드는\n대표적인 전신 운동입니다.',
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
                  image: AssetImage('assets/squat.png'),
                  fit: BoxFit.fitWidth,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_back_ios_new),
                    iconSize: 70,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  IconButton(
                    onPressed: () {},
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
                        '배, 상체 근육',
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
                        '뱃살이 고민이에요\n체지방 태우고 싶어요',
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
                      '${_remainTime ~/ 60}분 ${_remainTime % 60}초',
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

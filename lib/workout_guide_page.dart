import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'workout.dart';

class WorkoutGuidePage extends StatefulWidget {
  const WorkoutGuidePage({super.key});

  @override
  State<WorkoutGuidePage> createState() => _WorkoutGuidePageState();
}

class _WorkoutGuidePageState extends State<WorkoutGuidePage> {
  final _player = AudioPlayer();
  Timer? _timer;
  bool _isPlaying = false;

  final List<Workout> workouts = [
    Workout(
      name: '스쿼트',
      imageName: 'squat.png',
      minutes: 30,
      audioName: 'squat.mp3',
      description: '하체 근력을 강화하고\n탄력 있는 엉덩이 라인을 만드는\n대표적인 전신 운동입니다.',
      target: '배, 상체 근육',
      recommend: '뱃살이 고민이에요\n체지방 태우고 싶어요',
      kcal: 200,
    ),
    Workout(
      name: '마운틴 클라이머',
      minutes: 20,
      imageName: 'mountain_climber.png',
      audioName: 'mountain_climber.mp3',
      description: '엎드린 자세에서 다리를 빠르게 교차하며\n코어와 심폐 지구력을 동시에 기르는\n유산소성 운동입니다.',
      target: '전신, 복부 코어',
      recommend: '칼로리 태우고 싶어요\n전신 탄력 원해요',
      kcal: 50,
    ),
    Workout(
      name: '푸시업',
      minutes: 15,
      imageName: 'push_up.png',
      audioName: 'push_up.mp3',
      description: '가슴, 어깨, 팔 삼두근을 포함한\n상체 전반의 근력을 발달시키는\n맨몸 운동입니다.',
      target: '가슴, 삼두근',
      recommend: '상체 라인 원해요\n근력을 키우고 싶어요',
      kcal: 100,
    ),
    Workout(
      name: '윗몸 일으키기',
      minutes: 15,
      imageName: 'sit_up.png',
      audioName: 'sit_up.mp3',
      description: '복직근을 집중적으로 자극하여\n탄탄하고 선명한 복부 라인을\n만들어주는 운동입니다.',
      target: '복부 전체',
      recommend: '뱃살을 빼고 싶어요\n복근을 만들고 싶어요',
      kcal: 100,
    ),
    Workout(
      name: '사이드 런지',
      minutes: 20,
      imageName: 'side_lunge.png',
      audioName: 'side_lunge.mp3',
      description: '체중을 한쪽 다리로 이동하며\n허벅지 안쪽과 엉덩이 측면 근육을\n강화하는 운동입니다.',
      target: '허벅지, 엉덩이',
      recommend: '허벅지가 고민이에요\n힙 라인 정리 원해요',
      kcal: 100,
    ),
    Workout(
      name: '덩키 킥',
      minutes: 30,
      imageName: 'donkey_kick.png',
      audioName: 'donkey_kick.mp3',
      description: '다리를 뒤로 들어 올려\n엉덩이 윗부분을 집중적으로 자극하고\n힙업 효과를 주는 운동입니다.',
      target: '엉덩이 대둔근',
      recommend: '처진 힙이 고민이에요\n힙업 효과 원해요',
      kcal: 50,
    ),
    Workout(
      name: '사이드 플랭크',
      minutes: 20,
      imageName: 'side_plank.png',
      audioName: 'side_plank.mp3',
      description: '몸을 옆으로 세워 지탱하며\n옆구리와 심부 코어 근육의 안정성을\n높여주는 운동입니다.',
      target: '옆구리, 코어',
      recommend: '잘록한 허리 원해요\n코어 강화 원해요',
      kcal: 120,
    ),
    Workout(
      name: '리버스 플랭크',
      minutes: 15,
      imageName: 'reverse_plank.png',
      audioName: 'reverse_plank.mp3',
      description: '몸의 뒷면을 지탱하며\n척추기립근, 엉덩이, 햄스트링을 동시에\n강화하는 전신 운동입니다.',
      target: '척추, 등 근육',
      recommend: '자세 교정하고 싶어요\n뒷태를 가꾸고 싶어요',
      kcal: 120,
    ),
    Workout(
      name: '힙 브릿지',
      minutes: 25,
      imageName: 'hip_bridge.png',
      audioName: 'hip_bridge.mp3',
      description: '누운 자세에서 골반을 들어 올려 \n엉덩이 근육과 허리 건강을 탄탄하게\n가꿔주는 운동입니다.',
      target: '엉덩이, 허리',
      recommend: '허리 통증 있어요\n누워서 운동할래요',
      kcal: 80,
    ),
    Workout(
      name: '어깨 스트레칭',
      minutes: 15,
      imageName: 'shoulder_stretch.png',
      audioName: 'shoulder_stretch.mp3',
      description: '뭉친 어깨 주변 근육을\n부드럽게 이완하고 관절의 가동 범위를\n넓혀주는 스트레칭입니다.',
      target: '어깨, 승모근',
      recommend: '어깨가 너무 뭉쳤어요\n상체 피로 풀래요',
      kcal: 30,
    ),
    Workout(
      name: '햄스트링 스트레칭',
      minutes: 10,
      imageName: 'hamstring_stretch.png',
      audioName: 'hamstring_stretch.mp3',
      description: '허벅지 뒷쪽 근육을 시원하게\n늘려주어 하체 유연성을 높이고\n피로를 풀어주는 스트레칭입니다.',
      target: '허벅지 뒤쪽',
      recommend: '다리가 자꾸 부어요\n유연성을 기를래요',
      kcal: 30,
    ),
  ];

  late Workout _currentWorkout;
  late int _remainSeconds;
  int _workoutIndex = 0;

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.loop);
    _currentWorkout = workouts[_workoutIndex];
    _remainSeconds = _currentWorkout.minutes * 60;
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
  }

  void _prev() {
    _workoutIndex = (_workoutIndex - 1) % workouts.length;
    _currentWorkout = workouts[_workoutIndex];
    _remainSeconds = _currentWorkout.minutes * 60;
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
                  image: AssetImage('assets/${_currentWorkout.imageName}'),
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

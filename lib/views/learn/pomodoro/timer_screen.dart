import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_flutter/models/learn_models/pomodoro_set_model.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/views/home_page_screen.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/app_assets.dart';
import '../../../constants/app_styles.dart';
import '../../../providers/pomodoro_provider.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({
    Key? key,
    this.pomodoroSetModel,
    this.repeatCount,
  }) : super(key: key);

  final PomodoroSetModel? pomodoroSetModel;
  final int? repeatCount;

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  @override
  void initState() {
    print("init");
    // checkIfEnd();
    Timer(const Duration(microseconds: 1), () {
      scale = 1.5;
      topMargin = 200;
      opacity = 1.0;
    });
    if (widget.pomodoroSetModel != null) {
      writeSharedPreferences();
      startTime(60 * widget.pomodoroSetModel!.learnSectionTime!);
    } else {
      getTimerStatus();
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  var timerVar = 0;
  var scale = 1.0;
  var topMargin = 0.0;
  var opacity = 0.0;
  Timer? timer;
  int? remainingSeconds;
  String? time;
  bool isPaused = false;
  int? learnTime;
  int? repeatCount;
  int? totalCount;
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    remainingSeconds = ref.watch(timerRemainingTime);
    final theme = ref.watch(appThemeProvider);
    final pomodoroPhases = ref.read(pomodoroLearnPhaseProvider);
    return BaseScreenWidget(
      screenTitle: pomodoroPhases.isNotEmpty
          ? pomodoroPhases.length.isOdd
              ? "Uczymy się!"
              : "Przerwa"
          : "Uczymy się!",
      backIcon: () {
        Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: const HomePageScreen(),
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 350),
            ),
            (Route<dynamic> route) => false);
      },
      body: Stack(
        children: [
          repeatCount != null
              ? Positioned(
                  top: 24.0,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: opacity,
                    child: Container(
                      width: double.infinity,
                      child: FittedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Center(
                            child: Text(
                              !isFinished
                                  ? pomodoroPhases.length.isOdd
                                      ? "Etap ${repeatCount! - ((pomodoroPhases.length + 1) / 2).floor() + 1}/${repeatCount!}"
                                      : "Czas na przerwę! "
                                  : "Gratulację!\nSkończyłeś sejsę Pomodoro!",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            top: widget.pomodoroSetModel != null ? topMargin : 200,
            left: 0,
            right: 0,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 400),
              scale: widget.pomodoroSetModel != null ? scale : 1.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: 90.0,
                    animation: true,
                    animateFromLastPercent: true,
                    animationDuration: 1000,
                    lineWidth: 12.0,
                    percent: isFinished
                        ? 1
                        : ref.watch(pomodoroLearnPhaseProvider).isNotEmpty
                            ? percent(timerVar / (learnTime! * 60))
                            : 0.0,
                    center: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: theme.gradient,
                        shape: BoxShape.circle,
                      ),
                      height: 145,
                      child: Center(
                        child: time != null
                            ? isFinished
                                ? Image.asset(
                                    AppAssets.trophyIcon,
                                    color: Colors.white,
                                  )
                                : Text(
                                    widget.pomodoroSetModel != null
                                        ? time == null
                                            ? "${widget.pomodoroSetModel!.learnSectionTime}:00"
                                            : time!
                                        : time == null
                                            ? ""
                                            : "$time",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30.0,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                  )
                            : SpinKitPouringHourGlass(
                                color: Colors.white,
                                size: 50.0,
                              ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    backgroundColor: theme.mainColorLighter.withOpacity(0.5),
                    linearGradient: theme.gradientButton,
                  ),
                  Visibility(
                    visible: !isFinished,
                    maintainState: true,
                    maintainSize: true,
                    maintainAnimation: true,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isPaused = !isPaused;
                            });
                          },
                          child: Icon(
                            !isPaused
                                ? Icons.pause_circle_outline_outlined
                                : Icons.play_circle_outline_outlined,
                            color: theme.mainColor,
                            shadows: [
                              Shadow(
                                  color: theme.mainColorDarker,
                                  offset: Offset(1, 1),
                                  blurRadius: 8)
                            ],
                            size: 45,
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        InkWell(
                          onTap: () async {
                            final prefs = await SharedPreferences.getInstance();
                            prefs.remove("startedTime");
                            ref.invalidate(pomodoroLearnPhaseProvider);
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.stop_circle_outlined,
                            color: theme.mainColor,
                            shadows: [
                              Shadow(
                                  color: theme.mainColorDarker,
                                  offset: Offset(1, 1),
                                  blurRadius: 8)
                            ],
                            size: 45,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                      visible: isFinished,
                      maintainState: true,
                      maintainSize: true,
                      maintainAnimation: true,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Zakończ",
                            style: AppStyles.secondaryButtonStyle
                                .copyWith(color: theme.mainColor),
                          ),
                        ),
                      )),
                  InkWell(
                    onTap: () {
                      print(ref.watch(pomodoroLearnPhaseProvider));
                      print(ref.watch(timerRemainingTime));
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      mainColor: theme.mainColor,
    );
  }

  double percent(double percentage) {
    if (percentage >= 0 && percentage <= 1) {
      return percentage;
    } else {
      if (percentage < 0) {
        return 0.0;
      }
      if (percentage > 1) {
        return 1.0;
      }
    }
    return 0.0;
  }

  startTime(int seconds) {
    const duration = Duration(seconds: 1);
    //remainingSeconds = ref.watch(timerRemainingTime);
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds! < 0) {
        setState(() {
          time = "00:00";
        });
        timer.cancel();
        ref.read(pomodoroLearnPhaseProvider).removeAt(0);
        if (ref.read(pomodoroLearnPhaseProvider).isEmpty) {
          setState(() {
            isFinished = true;
          });
          clearSharedPreferences();
        } else {
          setState(() {
            learnTime = ref.read(pomodoroLearnPhaseProvider).first;
            print(learnTime);
            timerVar = 0;
          });
          startTime(ref.read(pomodoroLearnPhaseProvider).first * 60);
        }
      } else {
        int minutes = remainingSeconds! ~/ 60;
        int seconds = (remainingSeconds! % 60);
        if (!isPaused) {
          setState(() {
            time = minutes.toString().padLeft(2, "0") +
                ":" +
                seconds.toString().padLeft(2, "0");

            //remainingSeconds = remainingSeconds! - 1;
            ref.read(timerRemainingTime.notifier).state =
                ref.read(timerRemainingTime.notifier).state! - 1;
            print(ref.watch(timerRemainingTime));
            timerVar++;
          });
        }
      }
    });
  }
  /*startTime(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds! < 0) {
        setState(() {
          time = "00:00";
        });
        timer.cancel();
        ref.read(pomodoroLearnPhaseProvider).removeAt(0);
        if (ref.read(pomodoroLearnPhaseProvider).isEmpty) {
          setState(() {
            isFinished = true;
          });
          clearSharedPreferences();
        } else {
          setState(() {
            learnTime = ref.read(pomodoroLearnPhaseProvider).first;
            print(learnTime);
            timerVar = 0;
          });
          startTime(ref.read(pomodoroLearnPhaseProvider).first * 60);
        }
      } else {
        int minutes = remainingSeconds! ~/ 60;
        int seconds = (remainingSeconds! % 60);
        if (!isPaused) {
          setState(() {
            time = minutes.toString().padLeft(2, "0") +
                ":" +
                seconds.toString().padLeft(2, "0");

            remainingSeconds = remainingSeconds! - 1;
            timerVar++;
          });
        }
      }
    });
  }*/

  Future<void> getTimerStatus() async {
    final currentPhase = ref.read(pomodoroLearnPhaseProvider).first;

    final prefs = await SharedPreferences.getInstance();
    final startedTime = prefs.getString('startedTime');
    final timeR =
        DateTime.now().difference(DateTime.parse(startedTime!)).inSeconds;
    // if(timerR > )
    setState(() {
      //remainingSeconds = timeR - ;
      /* time = "00:30";
      remainingSeconds = 300;
      timerVar = 30;*/
      learnTime = currentPhase;
      totalCount = prefs.getInt("repeatCount");
      repeatCount = ((totalCount! + 1) / 2).floor();
    });
    startTime(learnTime! * 60);
  }

  Future<void> writeSharedPreferences() async {
    final currentPhase = ref.read(pomodoroLearnPhaseProvider).first;
    learnTime = currentPhase;
    totalCount = widget.repeatCount;
    repeatCount = widget.repeatCount;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('startedTime', DateTime.now().toString());
    if (widget.pomodoroSetModel != null) {
      await prefs.setInt('repeatCount', widget.repeatCount! * 2 - 1);
      await prefs.setString(
          'pomodoroSet', jsonEncode(widget.pomodoroSetModel!.toJson()));
    }
  }

  void startTimer() {
    ref.read(timerRemainingTime.notifier).state =
        ref.watch(pomodoroLearnPhaseProvider).first;
  }

  Future<void> clearSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('startedTime');
    prefs.remove('repeatCount');
    prefs.remove('pomodoroSet');
  }
}

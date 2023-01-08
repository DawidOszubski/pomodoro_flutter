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
    getSharedPreferences();
    Timer(Duration(microseconds: 1), () {
      scale = 1.5;
      topMargin = 200;
    });
    if (widget.pomodoroSetModel != null) {
      writeSharedPreferences();
      startTime(60 * widget.pomodoroSetModel!.learnSectionTime!);
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
  Timer? timer;
  int? remainingSeconds;
  String? time;
  bool isPaused = false;
  int? learnTime;
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return BaseScreenWidget(
      screenTitle: "Uczymy się!",
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
                    animation: false,
                    animationDuration: 1200,
                    lineWidth: 12.0,
                    percent: widget.pomodoroSetModel != null
                        ? timerVar /
                            (60 * widget.pomodoroSetModel!.learnSectionTime!)
                        : learnTime != null
                            ? timerVar / (learnTime! * 60)
                            : 0,
                    center: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: theme.gradient,
                        shape: BoxShape.circle,
                      ),
                      height: 145,
                      child: Center(
                        child: time != null
                            ? Text(
                                widget.pomodoroSetModel != null
                                    ? time == null
                                        ? "${widget.pomodoroSetModel!.learnSectionTime}:00"
                                        : time!
                                    : time == null
                                        ? ""
                                        : "$time", //"${widget.pomodoroSetModel.learnSectionTime - timer} min",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )
                            : SpinKitPouringHourGlass(
                                color: Colors.white,
                                size: 50.0,
                              ),
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.butt,
                    backgroundColor: theme.mainColorLighter.withOpacity(0.5),
                    linearGradient: theme.gradientButton,
                  ),
                  Row(
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
                ],
              ),
            ),
          ),
        ],
      ),
      mainColor: theme.mainColor,
    );
  }

  startTime(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds! < 0) {
        setState(() {
          time = "00:00";
        });
        timer.cancel();
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
  }

  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    learnTime =
        PomodoroSetModel.fromJson(jsonDecode(prefs.getString('pomodoroSet')!))
            .learnSectionTime;
    final startedTime = DateTime.parse(prefs.getString('startedTime')!);
    if (DateTime.now()
        .isAfter(startedTime.add(Duration(minutes: learnTime!)))) {
      print("finished");
    } else {
      setState(() {
        learnTime = learnTime;
        timerVar = DateTime.now().difference(startedTime).inSeconds;
        startTime(DateTime.now()
                .difference(startedTime.add(Duration(minutes: learnTime!)))
                .inSeconds *
            -1);
      });
    }
  }

  Future<void> writeSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('startedTime', DateTime.now().toString());
    if (widget.pomodoroSetModel != null) {
      await prefs.setInt('repeatCount', widget.repeatCount!);
      await prefs.setString(
          'pomodoroSet', jsonEncode(widget.pomodoroSetModel!.toJson()));
    }
  }

  /*Future<void> checkIfEnd() async {
    final time = await getSharedPreferences();
    if (time != null) {
      print(PomodoroSetModel.fromJson(jsonDecode(time)).learnSectionTime);
    }
  }*/
}

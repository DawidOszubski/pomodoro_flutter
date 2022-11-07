import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_flutter/models/pomodoro_set_model.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({
    Key? key,
    required this.pomodoroSetModel,
  }) : super(key: key);

  final PomodoroSetModel pomodoroSetModel;

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  @override
  void initState() {
    startTime(60);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //var timeRemaining = 25.0;
  var timerVar = 0.0;
  Timer? timer;
  int remainingSeconds = 60;
  String time = "01:00";
  @override
  Widget build(BuildContext context) {
    var timeRemaining = widget.pomodoroSetModel.learnSectionTime;
    final theme = ref.watch(appThemeProvider);

    return BaseScreenWidget(
      screenTitle: "Uczymy się!",
      body: Hero(
        tag: "timer",
        child: Material(
          color: Colors.white,
          child: AnimatedScale(
            duration: const Duration(milliseconds: 200),
            scale: 1.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 90.0,
                  animation: false,
                  animationDuration: 1200,
                  lineWidth: 12.0,
                  percent: timerVar / 60,
                  center: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: theme.gradient,
                      shape: BoxShape.circle,
                    ),
                    height: 145,
                    child: Center(
                      child: Text(
                        time, //"${widget.pomodoroSetModel.learnSectionTime - timer} min",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  circularStrokeCap: CircularStrokeCap.butt,
                  backgroundColor: theme.mainColorLighter.withOpacity(0.5),
                  linearGradient: theme.gradientButton,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.not_started_outlined,
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
        ),
      ),
      mainColor: theme.mainColor,
    );
  }

  startTime(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        setState(() {
          time = "00:00";
        });
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        setState(() {
          time = minutes.toString().padLeft(2, "0") +
              ":" +
              seconds.toString().padLeft(2, "0");

          remainingSeconds--;
          timerVar++;
        });
      }
    });
  }
}

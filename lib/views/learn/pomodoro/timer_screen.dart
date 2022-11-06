import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:pomodoro_flutter/widgets/base_screen_widget.dart';

class TimerScreen extends ConsumerStatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends ConsumerState<TimerScreen> {
  var time = 10;

  DateTime? date;

  @override
  void initState() {
    date = DateTime.utc(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        DateTime.now().hour,
        DateTime.now().minute,
        DateTime.now().second + time);
    super.initState();
  }

  final controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return BaseScreenWidget(
      screenTitle: "Uczymy się!",
      body: /*CircularCountDownTimer(
        duration: time,
        initialDuration: 0,
        controller: controller,
        width: 200,
        height: MediaQuery.of(context).size.height / 2,
        ringColor: Colors.grey[300]!,
        ringGradient: null,
        fillColor: theme.mainColor,
        fillGradient: null,
        backgroundColor: theme.mainColor,
        backgroundGradient: null,
        strokeWidth: 20.0,
        strokeCap: StrokeCap.round,
        textStyle: TextStyle(
            fontSize: 33.0, color: Colors.white, fontWeight: FontWeight.bold),
        textFormat: CountdownTextFormat.S,
        isReverse: false,
        isReverseAnimation: false,
        isTimerTextShown: true,
        autoStart: true,
        onStart: () {
          debugPrint('Countdown Started');
        },
        onComplete: () {
          debugPrint('Countdown Ended');
        },
        onChange: (String timeStamp) {
          debugPrint('Countdown Changed $timeStamp');
        },
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (date!.difference(DateTime.now()).inMicroseconds <= 0) {
            return "Czas na\nprzerwę!";
          } else {
            if (date!.difference(DateTime.now()).inMinutes < 10) {
              if ((date!.difference(DateTime.now()).inSeconds) -
                      (date!.difference(DateTime.now()).inMinutes) * 60 <
                  10) {
                return "0${date!.difference(DateTime.now()).inMinutes}:0${(date!.difference(DateTime.now()).inSeconds) - (date!.difference(DateTime.now()).inMinutes) * 60}";
              } else {
                return "0${date!.difference(DateTime.now()).inMinutes}:${(date!.difference(DateTime.now()).inSeconds) - (date!.difference(DateTime.now()).inMinutes) * 60}";
              }
            } else {
              if ((date!.difference(DateTime.now()).inSeconds) -
                      (date!.difference(DateTime.now()).inMinutes) * 60 <
                  10) {
                return "${date!.difference(DateTime.now()).inMinutes}:0${(date!.difference(DateTime.now()).inSeconds) - (date!.difference(DateTime.now()).inMinutes) * 60}";
              } else {
                return "${date!.difference(DateTime.now()).inMinutes}:${(date!.difference(DateTime.now()).inSeconds) - (date!.difference(DateTime.now()).inMinutes) * 60}";
              }
            }
          }
          //return DateTime.now().difference(date);
          // return DateFormat("mm:ss").format(DateTime.now().difference(date));
          /*if (duration.inSeconds == time) {
            return "Przerwa";
          } else {
            return (time - double.parse(controller.getTime()!)).toString();
          }*/
        },
      ),*/
          Hero(
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
                  percent: 1,
                  center: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: theme.gradient,
                      shape: BoxShape.circle,
                    ),
                    height: 145,
                    child: Center(
                      child: Text(
                        "25 min",
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
}

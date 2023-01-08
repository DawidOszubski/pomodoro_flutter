import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pomodoro_flutter/providers/pomodoro_provider.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/learn_models/pomodoro_set_model.dart';
import '../views/learn/pomodoro/timer_screen.dart';

class HomePageListItemWidget extends ConsumerStatefulWidget {
  const HomePageListItemWidget({
    Key? key,
    this.imageAsset,
    required this.nextScreen,
    this.isPomodoroScreen,
    this.icon,
  }) : super(key: key);

  final String? imageAsset;
  final Widget nextScreen;
  final bool? isPomodoroScreen;
  final Widget? icon;
  @override
  _HomePageListItemWidgetState createState() => _HomePageListItemWidgetState();
}

class _HomePageListItemWidgetState extends ConsumerState<HomePageListItemWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 200),
  )..addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          if (widget.isPomodoroScreen != null) {
            if (isTimerRunning) {
              print(ref.watch(timerRemainingTime));
              getTimerPrefs().then((value) => Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: TimerScreen())));
            } else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: widget.nextScreen));
            }
          } else {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: widget.nextScreen));
          }

          _controller.reverse();
        }
      },
    );
  Future<void> getSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isTimerRunning = prefs.getString('startedTime') != null;
    });
  }

  bool isTimerRunning = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(appThemeProvider);
    final DecorationTween decorationTween = DecorationTween(
      begin: BoxDecoration(
        gradient: themeData.gradientButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
        boxShadow: [
          BoxShadow(
            color: themeData.mainColorLighter.withOpacity(0.6),
            offset: const Offset(-1.0, -1.0),
            blurRadius: 4.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: themeData.mainColorDarker,
            offset: const Offset(4.0, 6.0),
            blurRadius: 3.0,
            spreadRadius: 1.0,
          ),
          BoxShadow(
            color: themeData.mainColorDarker.withOpacity(0.9),
            offset: const Offset(3.0, 6.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      end: BoxDecoration(
        gradient: themeData.gradientButton,
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    );
    return InkWell(
      onTap: () async {
        await getSharedPreferences();
        _controller.forward();
      },
      child: DecoratedBoxTransition(
        decoration: decorationTween.animate(_controller),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: widget.imageAsset != null
              ? Image.asset(
                  widget.imageAsset!,
                  fit: BoxFit.contain,
                )
              : widget.icon,
        ),
      ),
    );
  }

  Future<void> getTimerPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final repeatCount = prefs.getInt("repeatCount");
    final startedTime = prefs.getString('startedTime');
    var timeDiff =
        DateTime.now().difference(DateTime.parse(startedTime!)).inSeconds;
    final pomodoroSet =
        PomodoroSetModel.fromJson(jsonDecode(prefs.getString('pomodoroSet')!));
    ref.read(pomodoroLearnPhaseProvider.notifier).state =
        List.generate(repeatCount!, (index) {
      if (repeatCount.isOdd) {
        if (index % 2 == 0) {
          return pomodoroSet.learnSectionTime!;
        } else {
          return pomodoroSet.breakTime!;
        }
      } else {
        if (index % 2 == 0) {
          return pomodoroSet.learnSectionTime!;
        } else {
          return pomodoroSet.breakTime!;
        }
      }
    });
    while (timeDiff >= ref.watch(pomodoroLearnPhaseProvider).first * 60) {
      timeDiff -= ref.watch(pomodoroLearnPhaseProvider).first * 60;
      ref.watch(pomodoroLearnPhaseProvider.notifier).state.removeAt(0);
      if (ref.watch(pomodoroLearnPhaseProvider).isEmpty) {
        prefs.remove('startedTime');
        prefs.remove('repeatCount');
        prefs.remove('pomodoroSet');
        setState(() {
          isTimerRunning = false;
        });
        return;
      }
    }
  }
}

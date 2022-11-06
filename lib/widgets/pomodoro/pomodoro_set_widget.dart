import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pomodoro_flutter/providers/theme_provider.dart';

class PomodoroSetWidget extends ConsumerStatefulWidget {
  const PomodoroSetWidget({
    Key? key,
    required this.learnTime,
    required this.breakTime,
  }) : super(key: key);

  final int learnTime;
  final int breakTime;

  @override
  _PomodoroSetWidgetState createState() => _PomodoroSetWidgetState();
}

class _PomodoroSetWidgetState extends ConsumerState<PomodoroSetWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(child: Text("Czas jednego pomodoro")),
              SizedBox(
                width: 20,
              ),
              Flexible(child: Text("${widget.learnTime} min")),
            ],
          ),
        ),
        Divider(
          color: theme.mainColor,
          height: 1,
          thickness: 1,
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Text(
                  "Czas przerwy",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  "${widget.breakTime} min",
                ),
              ),
            ],
          ),
        ),
        Divider(
          color: theme.mainColor,
          height: 1,
          thickness: 1,
        ),
        Flexible(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: Text(
                  "Ilość sesji pomodoro",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  "8",
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class PomodoroSetWidget extends StatefulWidget {
  const PomodoroSetWidget({Key? key}) : super(key: key);

  @override
  State<PomodoroSetWidget> createState() => _PomodoroSetWidgetState();
}

class _PomodoroSetWidgetState extends State<PomodoroSetWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    Flexible(child: Text("Czas jednego pomodoro")),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Flexible(child: Text("Czas przerwy")),
                  ],
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              Flexible(
                child: Column(
                  children: [Flexible(child: Text("czas dłuższej przerwy"))],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Flexible(child: Text("Ilość sesji pomodoro")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

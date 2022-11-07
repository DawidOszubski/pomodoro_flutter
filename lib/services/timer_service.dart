import 'dart:async';

class TimerService {
  int remainingSeconds = 1;

  startTime(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        String time = minutes.toString().padLeft(2, "0") +
            ":" +
            seconds.toString().padLeft(2, "0");
      }
    });
  }
}
